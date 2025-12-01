## baz - Azure CLI extension

baz is an Azure CLI extension which aims to provide simple console functionality within Azure CLI inspired by Mike Bailey's bash-my-aws (https://github.com/mbailey/bash-my-aws)

### Features

- **Modular architecture**: Commands organized into modules (vnet, vm, subscription, defaults)
- **Tabular output**: Clean, formatted output similar to bash-my-aws
- **Tab completion**: Bash and Zsh completion support for commands and arguments
- **Simple interface**: Intuitive command structure for common Azure operations

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd bash_my_azure

# Make the script executable
chmod +x baz

# Add to your PATH (optional)
export PATH="$PATH:$(pwd)"

# Enable tab completion
# For Bash: add to ~/.bashrc for persistence
source baz-completion.sh

# For Zsh: add to ~/.zshrc for persistence
source baz-completion.sh
```

### Usage

```bash
# General syntax
baz <module> <command> [options]

# List available modules
baz

# See module-specific commands
baz <module>
```

### Available Modules

Modules can be accessed by their full name or short alias (shown in parentheses).

#### Virtual Networks (vnet)
```bash
# List all virtual networks
baz vnet list
```

Example output:
```
---------------------------------------------------
resource_group       vnet_name            cidr_range           peer_connected
rg_azure             core_network         192.168.0.0/16       yes
---------------------------------------------------
```

#### Virtual Machines (vm)
```bash
# List all virtual machines
baz vm list
```

#### Subscription Management (subscription, sub)
```bash
# List all subscriptions
baz subscription list
baz sub list              # Using alias

# Show current subscription
baz subscription show
baz sub show              # Using alias

# Set active subscription
baz subscription set <subscription-id-or-name>
baz sub set <subscription-id-or-name>   # Using alias
```

#### Default Settings (defaults, def)
```bash
# List current defaults
baz defaults list
baz def list              # Using alias

# Set default resource group
baz defaults set-group <resource-group-name>
baz def set-group <resource-group-name>   # Using alias

# Set default location
baz defaults set-location <location-name>
baz def set-location <location-name>      # Using alias

# Unset defaults
baz defaults unset-group
baz defaults unset-location
```

#### Resource Groups (resource_group, rg)
```bash
# List all resource groups
baz resource_group list
baz rg list               # Using alias
```

#### Regions (region, reg)
```bash
# List all available Azure regions/locations
baz region list
baz reg list              # Using alias
```

#### Application Proxy (app_proxy, ap)
```bash
# List all Application Proxy connector groups
baz app_proxy list-connector-groups
baz ap list-connector-groups              # Using alias

# List connectors in a specific group
baz app_proxy list-connectors --group-id <connector-group-id>
baz ap list-connectors --group-id <connector-group-id>   # Using alias

# List applications bound to a specific group
baz app_proxy list-applications --group-id <connector-group-id>
baz ap list-applications --group-id <connector-group-id>  # Using alias
```

**Note:** Application Proxy commands require Microsoft Graph API permissions:
- `Directory.Read.All` or `Application.Read.All`

### Requirements

- Azure CLI (`az`)
- `jq` for JSON processing
- Bash 4.0+ or Zsh 5.0+

