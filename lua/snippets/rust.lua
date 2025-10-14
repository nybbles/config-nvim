local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
  -- Struct with derives
  s("struct", fmt([[
    #[derive({derives})]
    pub struct {name} {{
        {fields}
    }}
  ]], {
    derives = i(1, "Debug, Clone, PartialEq"),
    name = i(2, "MyStruct"),
    fields = i(0, "pub field: String,")
  })),

  -- Enum with derives
  s("enum", fmt([[
    #[derive({derives})]
    pub enum {name} {{
        {variants}
    }}
  ]], {
    derives = i(1, "Debug, Clone, PartialEq"),
    name = i(2, "MyEnum"),
    variants = i(0, "Variant1,\n    Variant2(String),")
  })),

  -- Implementation block
  s("impl", fmt([[
    impl {trait_for}{name} {{
        {methods}
    }}
  ]], {
    trait_for = c(1, {t(""), fmt("{} for ", {i(1, "Trait")})}),
    name = i(2, "MyStruct"),
    methods = i(0, "pub fn new() -> Self {\n        Self\n    }")
  })),

  -- New function
  s("new", fmt([[
    pub fn new({params}) -> Self {{
        Self {{
            {fields}
        }}
    }}
  ]], {
    params = i(1),
    fields = i(0, "field: value,")
  })),

  -- Match expression with Result
  s("match", fmt([[
    match {expr} {{
        Ok({ok_val}) => {{
            {ok_body}
        }},
        Err({err_val}) => {{
            {err_body}
        }}
    }}
  ]], {
    expr = i(1, "result"),
    ok_val = i(2, "value"),
    ok_body = i(3, "value"),
    err_val = i(4, "err"),
    err_body = i(0, "eprintln!(\"Error: {}\", err);")
  })),

  -- Match expression with Option
  s("matchopt", fmt([[
    match {expr} {{
        Some({some_val}) => {{
            {some_body}
        }},
        None => {{
            {none_body}
        }}
    }}
  ]], {
    expr = i(1, "option"),
    some_val = i(2, "value"),
    some_body = i(3, "value"),
    none_body = i(0, "println!(\"None\");")
  })),

  -- Error type definition
  s("error", fmt([[
    #[derive(Debug)]
    pub enum {name}Error {{
        {variants}
    }}
    
    impl std::fmt::Display for {name}Error {{
        fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {{
            match self {{
                {display_arms}
            }}
        }}
    }}
    
    impl std::error::Error for {name}Error {{}}
  ]], {
    name = i(1, "My"),
    variants = i(2, "InvalidInput(String),\n    NetworkError,"),
    display_arms = i(0, "Self::InvalidInput(msg) => write!(f, \"Invalid input: {}\", msg),")
  })),

  -- Async function
  s("asyncfn", fmt([[
    pub async fn {name}({params}) -> Result<{return_type}, {error_type}> {{
        {body}
    }}
  ]], {
    name = i(1, "async_function"),
    params = i(2),
    return_type = i(3, "()"),
    error_type = i(4, "Box<dyn std::error::Error>"),
    body = i(0, "Ok(())")
  })),

  -- Test function
  s("test", fmt([[
    #[cfg(test)]
    mod tests {{
        use super::*;
        
        #[test]
        fn test_{name}() {{
            {body}
        }}
        
        #[tokio::test]
        async fn test_{name}_async() {{
            {async_body}
        }}
    }}
  ]], {
    name = i(1, "function"),
    body = i(2, "assert_eq!(1, 1);"),
    async_body = i(0, "assert_eq!(1, 1);")
  })),

  -- Tokio main
  s("tokiomain", fmt([[
    #[tokio::main]
    async fn main() -> Result<(), Box<dyn std::error::Error>> {{
        {body}
        Ok(())
    }}
  ]], {
    body = i(0, "println!(\"Hello, tokio!\");")
  })),

  -- Builder pattern
  s("builder", fmt([[
    pub struct {name}Builder {{
        {fields}
    }}
    
    impl {name}Builder {{
        pub fn new() -> Self {{
            Self {{
                {default_values}
            }}
        }}
        
        pub fn {field}(mut self, {field}: {field_type}) -> Self {{
            self.{field} = {field};
            self
        }}
        
        pub fn build(self) -> {name} {{
            {name} {{
                {build_fields}
            }}
        }}
    }}
    
    impl Default for {name}Builder {{
        fn default() -> Self {{
            Self::new()
        }}
    }}
  ]], {
    name = i(1, "Config"),
    fields = i(2, "field: Option<String>,"),
    default_values = i(3, "field: None,"),
    field = i(4, "field"),
    field_type = i(5, "String"),
    build_fields = i(0, "field: self.field.unwrap_or_default(),")
  })),

  -- Trait definition
  s("trait", fmt([[
    pub trait {name} {{
        {required_methods}
        
        fn {default_method}(&self) {{
            {default_impl}
        }}
    }}
  ]], {
    name = i(1, "MyTrait"),
    required_methods = i(2, "fn required_method(&self) -> String;"),
    default_method = i(3, "default_method"),
    default_impl = i(0, "println!(\"Default implementation\");")
  })),

  -- Macro definition
  s("macro", fmt([[
    macro_rules! {name} {{
        ({pattern}) => {{
            {expansion}
        }};
    }}
  ]], {
    name = i(1, "my_macro"),
    pattern = i(2, "$x:expr"),
    expansion = i(0, "println!(\"Value: {}\", $x);")
  })),

  -- Result type alias
  s("result", fmt([[
    pub type Result<T> = std::result::Result<T, {error_type}>;
  ]], {
    error_type = i(1, "Box<dyn std::error::Error>")
  })),

  -- Serde struct
  s("serde", fmt([[
    use serde::{{Serialize, Deserialize}};
    
    #[derive(Debug, Serialize, Deserialize{extra_derives})]
    pub struct {name} {{
        {fields}
    }}
  ]], {
    extra_derives = i(1, ", Clone, PartialEq"),
    name = i(2, "MyStruct"),
    fields = i(0, "pub field: String,")
  })),

  -- Clap CLI struct
  s("clap", fmt([[
    use clap::{{Args, Parser, Subcommand}};
    
    #[derive(Parser)]
    #[command(name = "{name}")]
    #[command(about = "{description}")]
    pub struct Cli {{
        #[command(subcommand)]
        pub command: Commands,
    }}
    
    #[derive(Subcommand)]
    pub enum Commands {{
        {commands}
    }}
  ]], {
    name = i(1, "my-cli"),
    description = i(2, "A CLI application"),
    commands = i(0, "Start { port: u16 },")
  })),

  -- Iterator chain
  s("iter", fmt([[
    {collection}
        .iter()
        .{chain}
        .collect::<{collect_type}>()
  ]], {
    collection = i(1, "vec"),
    chain = i(2, "filter(|x| **x > 0)\n        .map(|x| x * 2)"),
    collect_type = i(0, "Vec<_>")
  })),

  -- Closure
  s("closure", fmt([[
    let {name} = |{params}| {return_type} {{
        {body}
    }};
  ]], {
    name = i(1, "closure"),
    params = i(2, "x"),
    return_type = i(3, ""),
    body = i(0, "x + 1")
  })),

  -- Thread spawn
  s("thread", fmt([[
    let handle = std::thread::spawn(move || {{
        {body}
    }});
    
    {post_spawn}
    
    handle.join().unwrap();
  ]], {
    body = i(1, "println!(\"Thread is running\");"),
    post_spawn = i(0, "// Main thread continues")
  })),

  -- Mutex usage
  s("mutex", fmt([[
    let {name} = Arc::new(Mutex::new({value}));
    
    {{
        let mut guard = {name}.lock().unwrap();
        {critical_section}
    }}
  ]], {
    name = i(1, "shared_data"),
    value = i(2, "0"),
    critical_section = i(0, "*guard += 1;")
  })),
}