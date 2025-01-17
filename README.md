# life-progress-zsh

A simple zsh plugin to show your life progress in days, weeks, months, and age.

![](https://raw.githack.com/bGZo/assets/dev/2024/%E6%88%AA%E5%B1%8F2025-01-01%2010.17.20.png)

## Installation

### Manual Installation

Clone this repository and source the plugin in your `.zshrc` file:

```bash
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

