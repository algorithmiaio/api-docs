## Rust Algorithm Development

Algorithmia supports development of algorithms in Rust.

#### Handling Input and Output

> #### Handle text input by overriding `apply_str`:

```rust
#[derive(Default)]
pub struct Algo;

impl EntryPoint for Algo {
    fn apply_str(&self, input: &str) -> Result<AlgoOutput, Box<std::error::Error>> {
        let msg = format!("Hello {}", input);
        Ok(AlgoOutput::Text(msg))
    }
}
```

> #### Handle binary input by overriding `apply_bytes`:

```rust
#[derive(Default)]
pub struct Algo;

impl EntryPoint for Algo {
    fn apply_bytes(&self, input: &[u8]) -> Result<AlgoOutput, Box<std::error::Error>> {
       Ok(AlgoOutput::Binary(input.to_owned()))
    }
}
```

> #### Handle JSON input by overriding `apply_json`:

```rust
use rustc_serialize::json::Json;

#[derive(Default)]
pub struct Algo;

impl EntryPoint for Algo {
    fn apply_json(&self, input: &Json) -> Result<AlgoOutput, Box<std::error::Error>> {
      Ok(AlgoOutput::Json(input.to_owned()))
    }
}
```


> #### Auto-decode simple JSON arrays:

```rust
#[derive(Default)]
pub struct Algo;

impl DecodedEntryPoint for Algo {
    type Input = (String, u32);  // Handles JSON array input structured like: [String, Number]
    fn apply_decoded(&self, input: Self::Input) -> Result<AlgoOutput, Box<std::error::Error>> {
        let msg = format("Received string '{}' and number '{}", input.0, input.1);
        Ok(AlgoOutput::Text(msg))
    }
}
```

> #### Auto-decode structured JSON input:

```rust
#[derive(Default)]
pub struct Algo;

#[derive(RustcDecodable)]
pub struct TaskDefinition {
  foo: String,
  bar: u64,
}

impl DecodedEntryPoint for Algo {
    type Input = TaskDefinition;
    fn apply_decoded(&self, input: Self::Input) -> Result<AlgoOutput, Box<std::error::Error>> {
        let msg = format("Received string '{}' and number '{}", input.foo, input.bar);
        Ok(AlgoOutput::Text(msg))
    }
}
```

Rust algorithms are expected to have a public type named `Algo` that implements the [`algorithmia::algo::EntryPoint`](http://algorithmiaio.github.io/algorithmia-rust/algorithmia/algo/trait.EntryPoint.html) trait.
In many cases, you may prefer to implement [`algorithmia::algo::DecodedEntryPoint`](http://algorithmiaio.github.io/algorithmia-rust/algorithmia/algo/trait.DecodedEntryPoint.html) which provides an alternate implementation of `EntryPoint`.

How you implement `EntryPoint` depends entirely on the input you want your algorithm to receive.

- For text input, override [`apply_str`](http://algorithmiaio.github.io/algorithmia-rust/algorithmia/algo/trait.EntryPoint.html#method.apply_str)
- For binary input, override [`apply_bytes`](http://algorithmiaio.github.io/algorithmia-rust/algorithmia/algo/trait.EntryPoint.html#method.apply_bytes)
- For JSON input:
  - Override [`apply_json`](http://algorithmiaio.github.io/algorithmia-rust/algorithmia/algo/trait.EntryPoint.html#method.apply_json) if you want to work with the `rustc_serialize` [`Json` enum](https://doc.rust-lang.org/rustc-serialize/rustc_serialize/json/enum.Json.html) as input
  - Implement `DecodedEntryPoint` and override [`apply_decoded`](http://algorithmiaio.github.io/algorithmia-rust/algorithmia/algo/trait.DecodedEntryPoint.html#tymethod.apply_decoded) if you want to automatically decode the input to a type that you define

In all cases, the output of your algorithm will be `Result`-wrapped [`algorithmia::algo::AlgoOutput`](http://algorithmiaio.github.io/algorithmia-rust/algorithmia/algo/enum.AlgoOutput.html) which can represent text, json, or binary output.
There are several `From` conversions implemented to make it possible to simply `return Ok("Some text".into())`

There are several code snippets on the right to demonstrate the possibilities.

#### Error Handling

All the `apply` method variants return a `Result<AlgoOutput, Box<std::error::Error>>`,
which should make it possible to return almost any `Error` type, including by using the `try!` macro.
For simple algorithms, it may suffice to simply return `Err("some error message".into())`

#### Managing Dependencies

Algorithmia supports adding 3rd party dependencies via Cargo. Cargo dependencies typically come from <a href="https://crates.io/">Crates.io</a>
but it is also possible to specify dependendies from a git URL.

To configure depdendencies, click the 'Dependencies' button on the algorithm editor page which provides a way to edit the `Cargo.toml` file.
See the [Cargo Manifest](http://doc.crates.io/manifest.html#the-dependencies-section) for details on editting dependencies.

<aside class="notice">
  Note: By default the <code>algorithmia</code> dependency will be updated on every build to pick up any backward-compatible fixes.
  Updating other dependencies requires explicitly updating the version to cause a new <code>Cargo.lock</code> to be generated during
  the build process.
</aside>

<aside class="notice">
  Note: Editing the <code>[bin]</code> and <code>[lib]</code> section will likely break compilation, and may other build issues after future platform updates.
  If you believe your scenario requires such changes, contact us as we'd love to learn more about your usage scenario to better support it.
</aside>


#### Calling Other Algorithms and Managing Data

To call other algorithms or manage data from your algorithm, use the [Algorithmia Rust Client](http://developers.algorithmia.com/clients/rust/) which is available by default to any algorithm you create on the Algorithmia platform.

When designing your algorithm, don't forget that there are special data directories, `.session` and `.algo`, that are available only to algorithms to help you manage data over the course of the algorithm execution.


#### Additional Resources

* [Algorithmia Rust Client](http://developers.algorithmia.com/clients/rust/)
* [Rust standard library](https://doc.rust-lang.org/std/)
* [Crates.io](https://crates.io/)
