local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
  -- Basic flake
  s("flake", fmt([[
    {{
      description = "{description}";
      
      inputs = {{
        nixpkgs.url = "github:NixOS/nixpkgs/{nixpkgs_branch}";
        flake-utils.url = "github:numtide/flake-utils";
      }};
      
      outputs = {{ self, nixpkgs, flake-utils }}:
        flake-utils.lib.eachDefaultSystem (system:
          let
            pkgs = nixpkgs.legacyPackages.${{system}};
          in
          {{
            devShells.default = pkgs.mkShell {{
              buildInputs = with pkgs; [
                {build_inputs}
              ];
              
              shellHook = ''
                {shell_hook}
              '';
            }};
            
            packages.default = pkgs.stdenv.mkDerivation {{
              pname = "{pname}";
              version = "{version}";
              
              src = ./.;
              
              buildPhase = ''
                {build_phase}
              '';
              
              installPhase = ''
                {install_phase}
              '';
            }};
          }});
    }}
  ]], {
    description = i(1, "A Nix flake"),
    nixpkgs_branch = c(2, {t("nixos-unstable"), t("nixos-23.11"), t("nixpkgs-unstable")}),
    build_inputs = i(3, "nodejs\n        yarn"),
    shell_hook = i(4, "echo \"Development environment ready!\""),
    pname = i(5, "my-app"),
    version = i(6, "0.1.0"),
    build_phase = i(7, "echo \"Building...\""),
    install_phase = i(0, "mkdir -p $out/bin\n                cp result $out/bin/")
  })),

  -- NixOS configuration module
  s("nixos-module", fmt([[
    {{ config, lib, pkgs, ... }}:
    
    with lib;
    
    let
      cfg = config.services.{service_name};
    in {{
      options = {{
        services.{service_name} = {{
          enable = mkEnableOption "{service_description}";
          
          {option_name} = mkOption {{
            type = types.{option_type};
            default = {default_value};
            description = "{option_description}";
          }};
        }};
      }};
      
      config = mkIf cfg.enable {{
        {config_content}
      }};
    }}
  ]], {
    service_name = i(1, "myservice"),
    service_description = i(2, "my custom service"),
    option_name = i(3, "port"),
    option_type = c(4, {t("int"), t("str"), t("bool"), t("listOf str"), t("attrsOf str")}),
    default_value = i(5, "8080"),
    option_description = i(6, "Port to listen on"),
    config_content = i(0, "systemd.services.myservice = {\n        enable = true;\n        serviceConfig = {\n          ExecStart = \"${pkgs.mypackage}/bin/myservice\";\n        };\n      };")
  })),

  -- Package derivation
  s("derivation", fmt([[
    {{ lib, stdenv, fetchFromGitHub, {build_deps} }}:
    
    stdenv.mkDerivation rec {{
      pname = "{pname}";
      version = "{version}";
      
      src = fetchFromGitHub {{
        owner = "{owner}";
        repo = "{repo}";
        rev = "v${{version}}";
        sha256 = "{sha256}";
      }};
      
      nativeBuildInputs = [ {native_build_inputs} ];
      buildInputs = [ {build_inputs} ];
      
      configurePhase = ''
        {configure_phase}
      '';
      
      buildPhase = ''
        {build_phase}
      '';
      
      installPhase = ''
        {install_phase}
      '';
      
      meta = with lib; {{
        description = "{description}";
        homepage = "{homepage}";
        license = licenses.{license};
        maintainers = with maintainers; [ {maintainers} ];
        platforms = platforms.{platforms};
      }};
    }}
  ]], {
    build_deps = i(1, "cmake, pkg-config"),
    pname = i(2, "mypackage"),
    version = i(3, "1.0.0"),
    owner = i(4, "username"),
    repo = rep(2),
    sha256 = i(5, "0000000000000000000000000000000000000000000000000000"),
    native_build_inputs = i(6, "cmake pkg-config"),
    build_inputs = i(7, "openssl"),
    configure_phase = i(8, "cmake ."),
    build_phase = i(9, "make"),
    install_phase = i(10, "make install PREFIX=$out"),
    description = i(11, "A useful package"),
    homepage = i(12, "https://github.com/username/mypackage"),
    license = c(13, {t("mit"), t("gpl3"), t("bsd3"), t("apache2")}),
    maintainers = i(14, "maintainer-name"),
    platforms = c(15, {t("unix"), t("linux"), t("darwin")})
  })),

  -- Home Manager module
  s("home-manager", fmt([[
    {{ config, pkgs, ... }}:
    
    {{
      home.username = "{username}";
      home.homeDirectory = "/home/{username}";
      home.stateVersion = "{state_version}";
      
      programs = {{
        {program} = {{
          enable = true;
          {program_config}
        }};
      }};
      
      home.packages = with pkgs; [
        {packages}
      ];
      
      home.file.".{config_file}".text = ''
        {config_content}
      '';
      
      programs.home-manager.enable = true;
    }}
  ]], {
    username = i(1, "user"),
    state_version = i(2, "23.11"),
    program = i(3, "git"),
    program_config = i(4, "userName = \"Your Name\";\n          userEmail = \"your.email@example.com\";"),
    packages = i(5, "firefox\n        vscode"),
    config_file = i(6, "bashrc"),
    config_content = i(0, "# Custom bash configuration")
  })),

  -- Overlay
  s("overlay", fmt([[
    final: prev: {{
      {package_name} = prev.{base_package}.overrideAttrs (oldAttrs: {{
        {overrides}
      }});
      
      {new_package} = prev.callPackage ./packages/{new_package} {{ }};
    }}
  ]], {
    package_name = i(1, "customPackage"),
    base_package = i(2, "somePackage"),
    overrides = i(3, "version = \"1.2.3\";\n        src = prev.fetchurl {\n          url = \"https://example.com/source.tar.gz\";\n          sha256 = \"...\";\n        };"),
    new_package = i(0, "myNewPackage")
  })),

  -- Shell environment
  s("shell", fmt([[
    {{ pkgs ? import <nixpkgs> {{ }} }}:
    
    pkgs.mkShell {{
      buildInputs = with pkgs; [
        {build_inputs}
      ];
      
      shellHook = ''
        export {env_var}="{env_value}"
        
        {shell_hook}
        
        echo "Development shell activated!"
        echo "Available commands:"
        {help_commands}
      '';
    }}
  ]], {
    build_inputs = i(1, "nodejs\n        yarn\n        git"),
    env_var = i(2, "NODE_ENV"),
    env_value = i(3, "development"),
    shell_hook = i(4, "# Additional setup commands"),
    help_commands = i(0, "echo \"  yarn dev    - Start development server\"\n        echo \"  yarn test   - Run tests\"")
  })),

  -- NixOS service
  s("systemd-service", fmt([[
    systemd.services.{service_name} = {{
      description = "{description}";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      
      serviceConfig = {{
        Type = "{service_type}";
        ExecStart = "${{pkgs.{package}}}/bin/{executable} {args}";
        Restart = "always";
        RestartSec = "10";
        User = "{user}";
        Group = "{group}";
        
        # Security settings
        NoNewPrivileges = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        ReadWritePaths = [ "{rw_paths}" ];
      }};
      
      environment = {{
        {env_vars}
      }};
    }};
  ]], {
    service_name = i(1, "my-service"),
    description = i(2, "My custom service"),
    service_type = c(3, {t("simple"), t("forking"), t("oneshot"), t("notify")}),
    package = i(4, "mypackage"),
    executable = i(5, "myapp"),
    args = i(6, "--config /etc/myapp/config.yaml"),
    user = i(7, "myapp"),
    group = i(8, "myapp"),
    rw_paths = i(9, "/var/lib/myapp"),
    env_vars = i(0, "CONFIG_PATH = \"/etc/myapp/config.yaml\";")
  })),
}