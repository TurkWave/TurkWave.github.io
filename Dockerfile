# Local preview image for the Jekyll site. Ruby version matches CI
# (.github/workflows/pages.yml). The full image is used on purpose: some gems
# (eventmachine via em-websocket) compile native extensions.
FROM ruby:3.3

# The Gemfile lives outside /site so that the Gemfile.lock bundler generates
# stays in the image and never lands in the bind-mounted working tree.
# Changing the Gemfile requires `docker compose build`.
ENV BUNDLE_GEMFILE=/gems/Gemfile
WORKDIR /gems
COPY Gemfile ./
RUN bundle install

WORKDIR /site
COPY . .

EXPOSE 4000 35729

# --force_polling: file-change events do not cross a Docker Desktop (Windows/macOS) bind mount.
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--livereload", "--force_polling"]
