local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local datetime = os.date

local function get_class_name()
  return vim.fn.expand("%:t:r"):gsub("_", " "):gsub("(%l)(%w*)", function(a, b) return a:upper() .. b end):gsub(" ", "")
end

return {
  -- Async function with type hints
  s("asyncdef", fmt([[
    async def {func_name}({args}) -> {return_type}:
        """{docstring}"""
        {body}
  ]], {
    func_name = i(1, "function_name"),
    args = i(2, "self"),
    return_type = i(3, "None"),
    docstring = i(4, "Async function description."),
    body = i(0, "pass")
  })),

  -- PyTorch model class
  s("torch_model", fmt([[
    class {class_name}(nn.Module):
        def __init__(self{init_args}):
            super().__init__()
            {init_body}
        
        def forward(self, x: torch.Tensor) -> torch.Tensor:
            {forward_body}
            return x
  ]], {
    class_name = f(get_class_name, {}),
    init_args = i(1),
    init_body = i(2, "pass"),
    forward_body = i(0, "pass")
  })),

  -- Pytest test function
  s("pytest", fmt([[
    def test_{test_name}({fixtures}):
        """Test {description}."""
        # Given
        {given}
        
        # When
        {when}
        
        # Then
        {then}
  ]], {
    test_name = i(1, "something"),
    fixtures = i(2),
    description = rep(1),
    given = i(3, "pass"),
    when = i(4, "pass"),
    then = i(0, "pass")
  })),

  -- Pytest async test
  s("pytest_async", fmt([[
    @pytest.mark.asyncio
    async def test_{test_name}({fixtures}):
        """Test {description}."""
        # Given
        {given}
        
        # When
        {when}
        
        # Then
        {then}
  ]], {
    test_name = i(1, "something"),
    fixtures = i(2),
    description = rep(1),
    given = i(3, "pass"),
    when = i(4, "pass"),
    then = i(0, "pass")
  })),

  -- Type hint patterns
  s("typh", c(1, {
    t("List["),
    t("Dict[str, "),
    t("Optional["),
    t("Union["),
    t("Callable[["),
    t("AsyncIterator["),
    t("Awaitable["),
  })),

  -- Pydantic model
  s("pydantic", fmt([[
    class {model_name}(BaseModel):
        """{description}"""
        {fields}
        
        class Config:
            {config}
  ]], {
    model_name = i(1, "ModelName"),
    description = i(2, "Model description."),
    fields = i(3, "id: int"),
    config = i(0, "extra = 'forbid'")
  })),

  -- FastAPI endpoint
  s("fastapi", fmt([[
    @router.{method}("/{path}")
    async def {func_name}({params}) -> {return_type}:
        """{description}"""
        {body}
  ]], {
    method = c(1, {t("get"), t("post"), t("put"), t("delete")}),
    path = i(2, "endpoint"),
    func_name = rep(2),
    params = i(3),
    return_type = i(4, "dict"),
    description = i(5, "Endpoint description."),
    body = i(0, "return {}")
  })),

  -- Exception handling
  s("tryexcept", fmt([[
    try:
        {try_body}
    except {exception} as e:
        {except_body}
  ]], {
    try_body = i(1, "pass"),
    exception = i(2, "Exception"),
    except_body = i(0, "raise")
  })),

  -- Logging setup
  s("logger", fmt([[
    import logging
    
    logger = logging.getLogger(__name__)
    logger.setLevel(logging.{level})
    
    handler = logging.StreamHandler()
    formatter = logging.Formatter(
        '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
    )
    handler.setFormatter(formatter)
    logger.addHandler(handler)
  ]], {
    level = c(1, {t("INFO"), t("DEBUG"), t("WARNING"), t("ERROR")})
  })),

  -- Context manager
  s("contextmgr", fmt([[
    @contextmanager
    def {name}({args}):
        """{description}"""
        try:
            {setup}
            yield {yield_value}
        finally:
            {cleanup}
  ]], {
    name = i(1, "context_manager"),
    args = i(2),
    description = i(3, "Context manager description."),
    setup = i(4, "pass"),
    yield_value = i(5, "None"),
    cleanup = i(0, "pass")
  })),

  -- Dataclass
  s("dataclass", fmt([[
    @dataclass
    class {class_name}:
        """{description}"""
        {fields}
        
        def __post_init__(self):
            {post_init}
  ]], {
    class_name = i(1, "DataClass"),
    description = i(2, "Data class description."),
    fields = i(3, "value: int"),
    post_init = i(0, "pass")
  })),

  -- Async context manager
  s("async_contextmgr", fmt([[
    @asynccontextmanager
    async def {name}({args}):
        """{description}"""
        try:
            {setup}
            yield {yield_value}
        finally:
            {cleanup}
  ]], {
    name = i(1, "async_context_manager"),
    args = i(2),
    description = i(3, "Async context manager description."),
    setup = i(4, "pass"),
    yield_value = i(5, "None"),
    cleanup = i(0, "pass")
  })),

  -- Type stub
  s("typestub", fmt([[
    from typing import {imports}
    
    def {func_name}({args}) -> {return_type}: ...
  ]], {
    imports = i(1, "Any"),
    func_name = i(2, "function_name"),
    args = i(3),
    return_type = i(0, "Any")
  })),

  -- Property with getter/setter
  s("property", fmt([[
    @property
    def {name}(self) -> {return_type}:
        """{description}"""
        return self._{name}
    
    @{name}.setter
    def {name}(self, value: {value_type}) -> None:
        self._{name} = value
  ]], {
    name = i(1, "property_name"),
    return_type = i(2, "str"),
    description = i(3, "Property description."),
    value_type = rep(2)
  })),

  -- Main guard
  s("main", fmt([[
    if __name__ == "__main__":
        {body}
  ]], {
    body = i(0, "pass")
  })),
}