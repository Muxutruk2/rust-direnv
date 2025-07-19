use env_logger;
use log::info;

fn main() {
    env_logger::builder().format_timestamp(None).init();
    info!("Hello, world!");
}
