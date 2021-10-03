# ag Plugin for micro

This plugin provides the ability to search with "ag" (aka the_silver_searcher) in [micro](https://github.com/zyedidia/micro).

## Requirements

It requires that you have `ag` (aka the_silver_searcher) available in your path. For Arch Linux you install via `pacman -Syu the_silver_searcher`.

## Options

There are no configuration options at the moment.

## Usage

You can use `ag` as if it was on the command line: `> ag --lua function` or `ag function` - change "function" with your search string. Accepts all the same options as ag usually does.

## Install

Add this repo as a `pluginrepos` option like this:

```json
"pluginrepos": [
  "https://raw.githubusercontent.com/sebkolind/micro-ag/master/repo.json"
],
```

Install with `> plugin install ag`.

## Roadmap

- [x] Fix known issue with arguments to "ag" not working
