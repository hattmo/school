#![feature(never_type)]
use std::{borrow::Cow, path::Path};

use tokio::{
    fs::{OpenOptions, create_dir_all},
    io::{AsyncWriteExt, Result as IoResult},
};

use axum::{
    extract::{DefaultBodyLimit, Multipart},
    http::StatusCode,
    response::Html,
    routing::{Router, get, post},
    serve::serve,
};
use tower_http::trace::{DefaultOnResponse, TraceLayer};
use tower_http::{services::ServeDir, trace::DefaultMakeSpan};
use tracing::{Level, info, warn};

#[tokio::main]
async fn main() -> IoResult<()> {
    tracing_subscriber::fmt().init();
    info!("Starting server");
    let path = Path::new("/tmp/project1");
    create_dir_all(path).await?;
    info!("Created Cache");
    let router = Router::new()
        .route("/upload", post(post_video))
        .layer(DefaultBodyLimit::disable())
        .route("/", get(index))
        .nest_service("/videos", ServeDir::new("/tmp/project1"))
        .layer(
            TraceLayer::new_for_http()
                .make_span_with(DefaultMakeSpan::new().level(Level::INFO))
                .on_response(DefaultOnResponse::new().level(Level::INFO)),
        );
    let serve_socket = tokio::net::TcpListener::bind("0.0.0.0:80").await?;
    serve(serve_socket, router).await?;
    Ok(())
}

async fn index() -> Result<Html<String>, ()> {
    let mut read_dir = tokio::fs::read_dir("/tmp/project1/").await.unwrap();
    let mut content = r#"
<html>
    <body>
    <h1>Uploaded Videos</h1>
        <ul>
"#
    .to_owned();

    while let Ok(Some(dir_entry)) = read_dir.next_entry().await {
        let name = dir_entry.file_name().to_string_lossy().into_owned();
        content.push_str(&format!(r#"<li><a href="videos/{name}">{name}</a></li>"#));
    }
    content.push_str(
        r#"
        </ul>
    </body>
</html>
    "#,
    );
    Ok(Html(content))
}
async fn post_video(mut part: Multipart) -> Result<&'static str, (StatusCode, Cow<'static, str>)> {
    info!("New Upload Request");
    let mut found = false;
    while let Ok(Some(mut field)) = part.next_field().await {
        info!(?field);
        match (field.content_type(), field.file_name()) {
            (Some("video/mp4"), Some(name)) => {
                let mut name = name.trim_end_matches(".mp4").replace(['.', '/'], "");
                name.push_str(".mp4");
                let path = Path::new("/tmp/project1").join(name);
                let mut out_file = OpenOptions::new()
                    .write(true)
                    .create(true)
                    .open(&path)
                    .await
                    .map_err(|e| {
                        warn!(%e, "Failed to open storage");
                        (
                            StatusCode::BAD_REQUEST,
                            format!("Failed to open storage: {e}").into(),
                        )
                    })?;
                while let Some(mut chunk) = field.chunk().await.map_err(|e| {
                    let t = e.body_text();

                    warn!(%e,%t, "Failed to read chunk");
                    (
                        StatusCode::BAD_REQUEST,
                        format!("Failed to read chunk: {e}").into(),
                    )
                })? {
                    out_file.write_all_buf(&mut chunk).await.map_err(|e| {
                        warn!(%e, "Failed to write chunk");
                        (
                            StatusCode::INTERNAL_SERVER_ERROR,
                            format!("Failed to write data: {e}").into(),
                        )
                    })?;
                }
                // let content = field.bytes().await.map_err(|e| {
                //     let s = e.status();
                //     let t = e.body_text();
                //     warn!(%e, %s, %t, "BYTES ERROR");
                //     (
                //         StatusCode::BAD_REQUEST,
                //         format!("Failed to read content: {e}").into(),
                //     )
                // })?;
                // info!(?path, "Writing content");
                // write(path, content).await.map_err(|e| {
                //     warn!(%e, "WRITE ERROR");
                //     (
                //         StatusCode::BAD_REQUEST,
                //         format!("Failed to save file: {e}").into(),
                //     )
                // })?;
                info!("content written successfully");
                found = true;
            }
            (_, Some(name)) => {
                warn!("Bad File type for file: {name}");
            }
            _ => {
                warn!("No File type or name");
            }
        }
    }
    if !found {
        warn!("No File to upload")
    }
    found
        .then_some("Upload successful")
        .ok_or((StatusCode::BAD_REQUEST, "Failed to upload".into()))
}
