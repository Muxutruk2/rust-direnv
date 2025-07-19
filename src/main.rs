use env_logger;
use log::info;
mod modules;

fn main() {
    env_logger::builder().format_timestamp(None).init();
    let greet = modules::utils::greet("{{username}}");
    info!("{greet}");
}
