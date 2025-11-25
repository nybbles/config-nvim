local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
  -- Basic control flow snippets
  s("if", fmt([[
    if {condition} {{
        {body}
    }}
  ]], {
    condition = i(1, "true"),
    body = i(0, "// TODO")
  })),

  s("ife", fmt([[
    if {condition} {{
        {if_body}
    }} else {{
        {else_body}
    }}
  ]], {
    condition = i(1, "true"),
    if_body = i(2, "// TODO"),
    else_body = i(0, "// TODO")
  })),

  s("ifel", fmt([[
    if {condition1} {{
        {if_body}
    }} else if {condition2} {{
        {elif_body}
    }} else {{
        {else_body}
    }}
  ]], {
    condition1 = i(1, "true"),
    if_body = i(2, "// TODO"),
    condition2 = i(3, "false"),
    elif_body = i(4, "// TODO"),
    else_body = i(0, "// TODO")
  })),

  s("for", fmt([[
    for {item} in {iterator} {{
        {body}
    }}
  ]], {
    item = i(1, "item"),
    iterator = i(2, "items"),
    body = i(0, "// TODO")
  })),

  s("fori", fmt([[
    for {var} in {start}..{end} {{
        {body}
    }}
  ]], {
    var = i(1, "i"),
    start = i(2, "0"),
    ["end"] = i(3, "10"),
    body = i(0, "// TODO")
  })),

  s("while", fmt([[
    while {condition} {{
        {body}
    }}
  ]], {
    condition = i(1, "true"),
    body = i(0, "// TODO")
  })),

  s("loop", fmt([[
    loop {{
        {body}
    }}
  ]], {
    body = i(0, "// TODO")
  })),

  s("fn", fmt([[
    fn {name}({params}) {return_type}{{
        {body}
    }}
  ]], {
    name = i(1, "function_name"),
    params = i(2),
    return_type = c(3, {t(""), fmt("-> {}", {i(1, "Type")})}),
    body = i(0, "// TODO")
  })),

  s("let", fmt([[
    let {name} = {value};
  ]], {
    name = i(1, "var"),
    value = i(0, "value")
  })),

  s("letm", fmt([[
    let mut {name} = {value};
  ]], {
    name = i(1, "var"),
    value = i(0, "value")
  })),

  s("main", fmt([[
    fn main() {{
        {body}
    }}
  ]], {
    body = i(0, 'println!("Hello, world!");')
  })),

  s("println", fmt([[
    println!("{message}"{args});
  ]], {
    message = i(1, "{}"),
    args = i(0)
  })),

  s("print", fmt([[
    print!("{message}"{args});
  ]], {
    message = i(1, "{}"),
    args = i(0)
  })),

  s("eprintln", fmt([[
    eprintln!("{message}"{args});
  ]], {
    message = i(1, "{}"),
    args = i(0)
  })),

  s("dbg", fmt([[
    dbg!({expr});
  ]], {
    expr = i(0, "value")
  })),

  s("vec", fmt([[
    vec![{items}]
  ]], {
    items = i(0, "1, 2, 3")
  })),

  s("derive", fmt([[
    #[derive({traits})]
  ]], {
    traits = i(0, "Debug, Clone")
  })),

  s("cfg", fmt([[
    #[cfg({condition})]
  ]], {
    condition = i(0, "test")
  })),

  s("allow", fmt([[
    #[allow({lint})]
  ]], {
    lint = i(0, "dead_code")
  })),

  -- Advanced error handling snippets
  s("unwrap_or", fmt([[
    {expr}.unwrap_or({default})
  ]], {
    expr = i(1, "option"),
    default = i(0, "default")
  })),

  s("unwrap_or_else", fmt([[
    {expr}.unwrap_or_else(|| {fallback})
  ]], {
    expr = i(1, "option"),
    fallback = i(0, "panic!(\"Failed\")")
  })),

  s("map_or", fmt([[
    {expr}.map_or({default}, |{var}| {body})
  ]], {
    expr = i(1, "option"),
    default = i(2, "default"),
    var = i(3, "x"),
    body = i(0, "x")
  })),

  s("and_then", fmt([[
    {expr}.and_then(|{var}| {body})
  ]], {
    expr = i(1, "option"),
    var = i(2, "x"),
    body = i(0, "Some(x)")
  })),

  s("ok_or", fmt([[
    {expr}.ok_or({error})
  ]], {
    expr = i(1, "option"),
    error = i(0, "\"Error message\"")
  })),

  s("expect", fmt([[
    {expr}.expect("{message}")
  ]], {
    expr = i(1, "result"),
    message = i(0, "Expected valid value")
  })),

  -- Common iterator patterns
  s("collect", fmt([[
    {iterator}.collect::<{type}>()
  ]], {
    iterator = i(1, "iter"),
    ["type"] = i(0, "Vec<_>")
  })),

  s("filter_map", fmt([[
    {iterator}.filter_map(|{var}| {body}).collect()
  ]], {
    iterator = i(1, "iter"),
    var = i(2, "x"),
    body = i(0, "Some(x)")
  })),

  s("fold", fmt([[
    {iterator}.fold({init}, |{acc}, {item}| {body})
  ]], {
    iterator = i(1, "iter"),
    init = i(2, "0"),
    acc = i(3, "acc"),
    item = i(4, "item"),
    body = i(0, "acc + item")
  })),

  s("reduce", fmt([[
    {iterator}.reduce(|{acc}, {item}| {body})
  ]], {
    iterator = i(1, "iter"),
    acc = i(2, "acc"),
    item = i(3, "item"),
    body = i(0, "acc + item")
  })),

  -- String manipulation
  s("format", fmt([[
    format!("{fmt}"{args})
  ]], {
    fmt = i(1, "{}"),
    args = i(0, ", value")
  })),

  s("toString", fmt([[
    {expr}.to_string()
  ]], {
    expr = i(0, "value")
  })),

  s("into", fmt([[
    {expr}.into()
  ]], {
    expr = i(0, "value")
  })),

  -- Option and Result constructors
  s("Some", fmt([[
    Some({value})
  ]], {
    value = i(0, "value")
  })),

  s("None", "None"),

  s("Ok", fmt([[
    Ok({value})
  ]], {
    value = i(0, "value")
  })),

  s("Err", fmt([[
    Err({error})
  ]], {
    error = i(0, "error")
  })),

  -- Module structure
  s("mod", fmt([[
    mod {name} {{
        {body}
    }}
  ]], {
    name = i(1, "module"),
    body = i(0, "// Module content")
  })),

  s("use", fmt([[
    use {path};
  ]], {
    path = i(0, "std::collections::HashMap")
  })),

  s("pub", fmt([[
    pub {item}
  ]], {
    item = i(0, "fn function() {}")
  })),

  -- Conditional compilation
  s("cfg_test", fmt([[
    #[cfg(test)]
    mod tests {{
        use super::*;
        
        {body}
    }}
  ]], {
    body = i(0, "#[test]\nfn test_function() {\n    assert_eq!(1, 1);\n}")
  })),

  s("cfg_debug", fmt([[
    #[cfg(debug_assertions)]
    {body}
  ]], {
    body = i(0, "println!(\"Debug mode\");")
  })),

  -- Lifetime annotations
  s("lifetime", fmt([[
    {item}<'{lifetime}>
  ]], {
    item = i(1, "struct MyStruct"),
    lifetime = i(0, "a")
  })),

  -- Generic constraints
  s("where", fmt([[
    where
        {constraint}
  ]], {
    constraint = i(0, "T: Clone + Debug")
  })),

  -- Async patterns
  s("await", fmt([[
    {expr}.await
  ]], {
    expr = i(0, "async_function()")
  })),

  s("spawn", fmt([[
    tokio::spawn(async move {{
        {body}
    }})
  ]], {
    body = i(0, "// Async task")
  })),

  -- Smart pointers
  s("box", fmt([[
    Box::new({value})
  ]], {
    value = i(0, "value")
  })),

  s("rc", fmt([[
    Rc::new({value})
  ]], {
    value = i(0, "value")
  })),

  s("arc", fmt([[
    Arc::new({value})
  ]], {
    value = i(0, "value")
  })),

  s("refcell", fmt([[
    RefCell::new({value})
  ]], {
    value = i(0, "value")
  })),

  -- Common derives
  s("derive_debug", "#[derive(Debug)]"),
  s("derive_clone", "#[derive(Debug, Clone)]"),
  s("derive_eq", "#[derive(Debug, Clone, PartialEq, Eq)]"),
  s("derive_ord", "#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord)]"),
  s("derive_hash", "#[derive(Debug, Clone, PartialEq, Eq, Hash)]"),
  s("derive_default", "#[derive(Debug, Clone, Default)]"),
  s("derive_serde", "#[derive(Debug, Clone, Serialize, Deserialize)]"),

  -- Quick test snippets
  s("assert_eq", fmt([[
    assert_eq!({left}, {right});
  ]], {
    left = i(1, "actual"),
    right = i(0, "expected")
  })),

  s("assert_ne", fmt([[
    assert_ne!({left}, {right});
  ]], {
    left = i(1, "actual"),
    right = i(0, "unexpected")
  })),

  s("assert", fmt([[
    assert!({condition});
  ]], {
    condition = i(0, "true")
  })),

  -- Panic and todo
  s("panic", fmt([[
    panic!("{message}");
  ]], {
    message = i(0, "Not implemented")
  })),

  s("todo", "todo!()"),
  s("unreachable", "unreachable!()"),
  s("unimplemented", "unimplemented!()"),
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