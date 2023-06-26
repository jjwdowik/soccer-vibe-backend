# README

```
gem install foreman
foreman start -f Procfile.dev
```

Also can run server with the following for local development

https://github.com/jjwdowik/soccer-vibe-react repo uses 5100 by default for the API locally

```
bundle exec puma -C config/puma.rb -p 5100
```

Create a .env file from the .env.example

To populate matches and teams locally, you can run the following
```
GetTeamsJob.perform_now
GetMatchesJob.perform_now
```


Run console
```
foreman run rails console
```


