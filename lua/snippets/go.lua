local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local function to_camel_case(str)
  return str:gsub("_(%w)", string.upper):gsub("^%w", string.upper)
end

return {
  -- Echo HTTP handler
  s("echo", fmt([[
    func {handler_name}(c echo.Context) error {{
        {body}
        return c.JSON(http.Status{status_code}, {response})
    }}
  ]], {
    handler_name = i(1, "HandleSomething"),
    body = i(2, "// handler logic"),
    status_code = c(3, {t("OK"), t("Created"), t("BadRequest"), t("NotFound"), t("InternalServerError")}),
    response = i(0, "map[string]interface{}{}")
  })),

  -- Echo route group
  s("echogroup", fmt([[
    {group_name} := e.Group("/{path}")
    {group_name}.Use({middleware})
    {group_name}.GET("/{endpoint}", {handler})
  ]], {
    group_name = i(1, "api"),
    path = rep(1),
    middleware = i(2, "middleware.Logger()"),
    endpoint = i(3, "users"),
    handler = i(0, "handleUsers")
  })),

  -- MongoDB struct with BSON tags
  s("mongo", fmt([[
    type {struct_name} struct {{
        ID          primitive.ObjectID `bson:"_id,omitempty" json:"id,omitempty"`
        {fields}
        CreatedAt   time.Time          `bson:"created_at" json:"created_at"`
        UpdatedAt   time.Time          `bson:"updated_at" json:"updated_at"`
    }}
  ]], {
    struct_name = i(1, "Document"),
    fields = i(0, "Name string `bson:\"name\" json:\"name\"`")
  })),

  -- MongoDB collection operations
  s("mongocrud", fmt([[
    type {name}Repository struct {{
        collection *mongo.Collection
    }}
    
    func New{name}Repository(db *mongo.Database) *{name}Repository {{
        return &{name}Repository{{
            collection: db.Collection("{collection_name}"),
        }}
    }}
    
    func (r *{name}Repository) Create(ctx context.Context, {var_name} *{name}) error {{
        {var_name}.ID = primitive.NewObjectID()
        {var_name}.CreatedAt = time.Now()
        {var_name}.UpdatedAt = time.Now()
        
        _, err := r.collection.InsertOne(ctx, {var_name})
        return err
    }}
    
    func (r *{name}Repository) FindByID(ctx context.Context, id primitive.ObjectID) (*{name}, error) {{
        var {var_name} {name}
        err := r.collection.FindOne(ctx, bson.M{{"_id": id}}).Decode(&{var_name})
        if err != nil {{
            return nil, err
        }}
        return &{var_name}, nil
    }}
  ]], {
    name = i(1, "User"),
    collection_name = i(2, "users"),
    var_name = f(function(args) return args[1][1]:lower() end, {1})
  })),

  -- Error handling pattern
  s("errh", fmt([[
    if err != nil {{
        {action}
    }}
  ]], {
    action = c(1, {
      t("return err"),
      t("return nil, err"),
      t("log.Printf(\"error: %v\", err)"),
      fmt("return {}, err", {i(1, "defaultValue")}),
      fmt("c.JSON(http.StatusInternalServerError, echo.Map{{\"error\": \"{}\"}}) \n\t\treturn err", {i(1, "internal server error")})
    })
  })),

  -- Cobra command
  s("cobra", fmt([[
    var {cmd_name}Cmd = &cobra.Command{{
        Use:   "{use}",
        Short: "{short_desc}",
        Long:  `{long_desc}`,
        Run: func(cmd *cobra.Command, args []string) {{
            {body}
        }},
    }}
    
    func init() {{
        rootCmd.AddCommand({cmd_name}Cmd)
        {flags}
    }}
  ]], {
    cmd_name = i(1, "example"),
    use = rep(1),
    short_desc = i(2, "Short description"),
    long_desc = i(3, "Long description of the command."),
    body = i(4, "fmt.Println(\"Command executed\")"),
    flags = i(0, "// Add flags here")
  })),

  -- Wire provider
  s("wire", fmt([[
    func Provide{name}({deps}) (*{name}, error) {{
        return &{name}{{
            {fields}
        }}, nil
    }}
  ]], {
    name = i(1, "Service"),
    deps = i(2, "config *Config"),
    fields = i(0, "// initialize fields")
  })),

  -- JWT middleware
  s("jwtmw", fmt([[
    func JWTMiddleware(secret string) echo.MiddlewareFunc {{
        return echojwt.WithConfig(echojwt.Config{{
            SigningKey:  []byte(secret),
            TokenLookup: "header:Authorization:Bearer ",
            ErrorHandler: func(c echo.Context, err error) error {{
                return c.JSON(http.StatusUnauthorized, echo.Map{{
                    "error": "invalid or missing token",
                }})
            }},
        }})
    }}
  ]], {})),

  -- Validation struct
  s("validate", fmt([[
    type {struct_name} struct {{
        {fields}
    }}
    
    func (v *{struct_name}) Validate() error {{
        validate := validator.New()
        return validate.Struct(v)
    }}
  ]], {
    struct_name = i(1, "Request"),
    fields = i(0, "Name string `json:\"name\" validate:\"required\"`")
  })),

  -- HTTP client
  s("httpclient", fmt([[
    client := &http.Client{{
        Timeout: {timeout} * time.Second,
    }}
    
    req, err := http.NewRequestWithContext(ctx, "{method}", "{url}", {body})
    if err != nil {{
        return err
    }}
    
    req.Header.Set("Content-Type", "application/json")
    
    resp, err := client.Do(req)
    if err != nil {{
        return err
    }}
    defer resp.Body.Close()
    
    if resp.StatusCode != http.StatusOK {{
        return fmt.Errorf("request failed with status: %d", resp.StatusCode)
    }}
    
    {response_handling}
  ]], {
    timeout = i(1, "30"),
    method = c(2, {t("GET"), t("POST"), t("PUT"), t("DELETE")}),
    url = i(3, "https://api.example.com/endpoint"),
    body = i(4, "nil"),
    response_handling = i(0, "// handle response")
  })),

  -- Context with timeout
  s("ctxtimeout", fmt([[
    ctx, cancel := context.WithTimeout(context.Background(), {timeout}*time.Second)
    defer cancel()
    
    {body}
  ]], {
    timeout = i(1, "30"),
    body = i(0, "// use context")
  })),

  -- Interface definition
  s("interface", fmt([[
    type {interface_name} interface {{
        {methods}
    }}
  ]], {
    interface_name = i(1, "Repository"),
    methods = i(0, "Get(ctx context.Context, id string) (*Model, error)")
  })),

  -- Table-driven test
  s("tabletest", fmt([[
    func Test{function_name}(t *testing.T) {{
        tests := []struct {{
            name     string
            input    {input_type}
            expected {expected_type}
            wantErr  bool
        }}{{
            {{
                name:     "{test_case}",
                input:    {input_value},
                expected: {expected_value},
                wantErr:  {want_err},
            }},
        }}
        
        for _, tt := range tests {{
            t.Run(tt.name, func(t *testing.T) {{
                {test_body}
            }})
        }}
    }}
  ]], {
    function_name = i(1, "Something"),
    input_type = i(2, "string"),
    expected_type = i(3, "string"),
    test_case = i(4, "valid input"),
    input_value = i(5, "\"test\""),
    expected_value = i(6, "\"expected\""),
    want_err = i(7, "false"),
    test_body = i(0, "// test logic")
  })),

  -- GORM model
  s("gorm", fmt([[
    type {model_name} struct {{
        ID        uint           `json:"id" gorm:"primaryKey"`
        {fields}
        CreatedAt time.Time      `json:"created_at"`
        UpdatedAt time.Time      `json:"updated_at"`
        DeletedAt gorm.DeletedAt `json:"-" gorm:"index"`
    }}
    
    func ({receiver} *{model_name}) TableName() string {{
        return "{table_name}"
    }}
  ]], {
    model_name = i(1, "User"),
    fields = i(2, "Name string `json:\"name\" gorm:\"not null\"`"),
    receiver = f(function(args) return args[1][1]:lower() end, {1}),
    table_name = f(function(args) return args[1][1]:lower() .. "s" end, {1})
  })),
}