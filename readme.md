# life-progress-zsh

A simple zsh plugin to show your life progress in days, weeks, months, and age.

## Installation

### Manual Installation

Clone this repository and source the plugin in your `.zshrc` file:

```bash
git clone  https://github.com/bGZo/proxies.git
git clone -b shell --single-branch git@github.com:bGZo/life-progress.git ~/.zsh/life-progress
echo "source ~/.zsh/life-progress/life-progress.plugin.zsh" >> ~/.zshrc
```

## Usage

```shell
Usage: life-progress [target_date]

Options:
  target_date     end date to calculate, today default
                  format could be:
                     - 2025/01/01
                     - 2025-01-01
                     - 20250101
  -h              show help

example：
  life-progress             # today prompt
  life-progress 2030-01-01  # history prompt
```

## Config

Set your birthday on `life-progress.conf`.

