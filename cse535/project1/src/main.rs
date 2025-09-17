#![feature(never_type)]
use std::path::Path;

use tokio::{
    fs::{create_dir_all, remove_dir_all, write},
    io::Result as IoResult,
};

use axum::{
    extract::Multipart,
    response::Html,
    routing::{Router, get, post},
    serve::serve,
};
use tower_http::trace::{DefaultOnResponse, TraceLayer};
use tower_http::{services::ServeDir, trace::DefaultMakeSpan};
use tracing::{Level, info};

#[tokio::main]
async fn main() -> IoResult<()> {
    tracing_subscriber::fmt().init();
    info!("Starting server");
    let path = Path::new("/tmp/project1");
    remove_dir_all(path).await?;
    create_dir_all(path).await?;
    info!("Created Cache");
    let router = Router::new()
        .route("/upload", post(post_video))
        .route("/", get(index))
        .nest_service("/videos", ServeDir::new("/tmp/project1"))
        .layer(
            TraceLayer::new_for_http()
                .make_span_with(DefaultMakeSpan::new().level(Level::INFO))
                .on_response(DefaultOnResponse::new().level(Level::INFO)),
        );
    let serve_socket = tokio::net::TcpListener::bind("0.0.0.0:8080").await?;
    serve(serve_socket, router).await?;
    Ok(())
}

async fn index() -> Result<Html<String>, ()> {
    let mut read_dir = tokio::fs::read_dir("/tmp/project1/").await.unwrap();
    let mut content = r#"
<html>
    <body>
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
async fn post_video(mut part: Multipart) -> Result<&'static str, &'static str> {
    info!("New Upload Request");
    let found = false;
    while let Ok(Some(part)) = part.next_field().await {
        info!(?part);
        match (part.content_type(), part.file_name()) {
            (Some("video/mp4"), Some(name)) => {
                let mut name = name.trim_end_matches(".mp4").replace(['.', '/'], "");
                name.push_str(".mp4");
                let path = Path::new("/tmp/project1").join(name);
                let content = part.bytes().await.or(Err("Failed to read content"))?;
                write(path, content).await.or(Err("Failed to save file"))?;
            }
            _ => {}
        }
    }
    found
        .then_some("Upload successful")
        .ok_or("Failed to upload")
}
