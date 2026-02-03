# rust-template

### Usage
Install cargo generate:
```bash
cargo install cargo-generate
```

Install target:
```bash
rustup target add wasm32-wasip2
```

Install cargo fusion:
```bash
cargo install cargo-fusion
```

Create project from template:
```bash
cargo generate --git https://github.com/fusionwm/rust-template.git
```

Build the plugin:
```bash
cargo-fusion build
# output: target/plugins/#NAME.fsp
```
