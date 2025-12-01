#!/usr/bin/env bash

# Bash completion for baz

_baz_completion() {
  local cur prev modules
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"

  # Available modules (including aliases)
  modules="vnet vm subscription sub defaults def resource_group rg region reg app_proxy ap"

  # Module-specific commands
  local vnet_commands="list"
  local vm_commands="list"
  local subscription_commands="list show set"
  local sub_commands="list show set"
  local defaults_commands="list set-group set-location unset-group unset-location"
  local def_commands="list set-group set-location unset-group unset-location"
  local resource_group_commands="list"
  local rg_commands="list"
  local region_commands="list"
  local reg_commands="list"
  local app_proxy_commands="list-connector-groups list-connectors list-applications"
  local ap_commands="list-connector-groups list-connectors list-applications"

  # First argument: complete modules
  if [ $COMP_CWORD -eq 1 ]; then
    COMPREPLY=( $(compgen -W "$modules" -- "$cur") )
    return 0
  fi

  # Second argument: complete module commands
  if [ $COMP_CWORD -eq 2 ]; then
    local module="${COMP_WORDS[1]}"
    case "$module" in
      vnet)
        COMPREPLY=( $(compgen -W "$vnet_commands" -- "$cur") )
        ;;
      vm)
        COMPREPLY=( $(compgen -W "$vm_commands" -- "$cur") )
        ;;
      subscription|sub)
        COMPREPLY=( $(compgen -W "$subscription_commands" -- "$cur") )
        ;;
      defaults|def)
        COMPREPLY=( $(compgen -W "$defaults_commands" -- "$cur") )
        ;;
      resource_group|rg)
        COMPREPLY=( $(compgen -W "$resource_group_commands" -- "$cur") )
        ;;
      region|reg)
        COMPREPLY=( $(compgen -W "$region_commands" -- "$cur") )
        ;;
      app_proxy|ap)
        COMPREPLY=( $(compgen -W "$app_proxy_commands" -- "$cur") )
        ;;
    esac
    return 0
  fi

  # Third argument: context-specific completions
  if [ $COMP_CWORD -eq 3 ]; then
    local module="${COMP_WORDS[1]}"
    local command="${COMP_WORDS[2]}"

    case "$module" in
      subscription|sub)
        if [ "$command" = "set" ]; then
          # Complete with subscription names
          local subscriptions=$(az account list --query "[].name" -o tsv 2>/dev/null)
          COMPREPLY=( $(compgen -W "$subscriptions" -- "$cur") )
        fi
        ;;
      defaults|def)
        if [ "$command" = "set-group" ]; then
          # Complete with resource group names
          local resource_groups=$(az group list --query "[].name" -o tsv 2>/dev/null)
          COMPREPLY=( $(compgen -W "$resource_groups" -- "$cur") )
        elif [ "$command" = "set-location" ]; then
          # Complete with location names
          local locations=$(az account list-locations --query "[].name" -o tsv 2>/dev/null)
          COMPREPLY=( $(compgen -W "$locations" -- "$cur") )
        fi
        ;;
      app_proxy|ap)
        if [ "$command" = "list-connectors" ] || [ "$command" = "list-applications" ]; then
          # Complete with --group-id flag
          COMPREPLY=( $(compgen -W "--group-id" -- "$cur") )
        fi
        ;;
    esac
    return 0
  fi
}

# Register completion
complete -F _baz_completion baz
