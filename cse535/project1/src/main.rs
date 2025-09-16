#![feature(never_type)]
use std::path::Path;

use tokio::{
    fs::{create_dir_all, write},
    io::Result as IoResult,
};

use axum::{
    extract::Multipart,
    routing::{Router, get, post},
    serve::serve,
};
use tower_http::services::ServeDir;

#[tokio::main]
async fn main() -> IoResult<()> {
    let path = Path::new("/tmp/project1");
    create_dir_all(path).await?;
    let router = Router::new()
        .route("/upload", post(post_video))
        .route("/", get(index))
        .nest_service("/videos", ServeDir::new("/tmp/project1"));
    let serve_socket = tokio::net::TcpListener::bind("0.0.0.0:8080").await?;
    serve(serve_socket, router).await?;
    Ok(())
}
async fn index() -> &'static str {
    "Hello"
}
async fn post_video(mut part: Multipart) -> Result<&'static str, &'static str> {
    let found = false;
    while let Ok(Some(part)) = part.next_field().await {
        match (part.content_type(), part.file_name()) {
            (Some("media/mp4"), Some(name)) => {
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
