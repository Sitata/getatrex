# Getatrex

**GETATREX** - **GET**text**A**utomatic**TR**anslator written in **E**li**X**ir

Translates *.POT* files generated by gettext in your Elixir/Phoenix project

## Installation

1. Install package

The package can be installed by adding `getatrex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:getatrex, "~> 0.1.0", only: :dev}]
end
```

2. Add Google Cloud Translation API Key 

If you don't have API key, you can get it in your Google Cloud Console https://console.cloud.google.com/apis/credentials

Open your `config/config.exs` file and add following:
```
config :getatrex, 
  key: "HERE_IS_YOUR_KEY"
```  

## Getting started

1. Follow instruction in the [Workflow section](https://github.com/elixir-lang/gettext#workflow) of the gettext library

2. Generate new locale, e.g. for Spanish this would be:
```
mix gettext.merge priv/gettext --locale es
```
3. Make `git commit -a -m 'added new spanish locale' to have this fixed in git with possibility to 

4. Translate new Spanish locale with getatrex:
```
> mix getatrex es
```

Now you have it translated and open your IDE to fix translations:
- fix silly translations
- fix gettext palceholders, e.g. `%{placeholder_name}`, which will be translated by Google as `% {placeholder_name}` (btw, could be automated as well)

