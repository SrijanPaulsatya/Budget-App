FROM ruby:3.1.2

RUN curl -O "https://nodejs.org/dist/v22.15.0/node-v22.15.0-linux-arm64.tar.xz" && \
    tar -xf node-v22.15.0-linux-arm64.tar.xz  && \
    cp -r node-v22.15.0-linux-arm64/* /usr/local/

 
WORKDIR /app
RUN gem install bundler

COPY Gemfile Gemfile.lock package.json package-lock.json .


RUN bundle install
RUN npm install

COPY . .


CMD ["bash", "-c", "bundle exec rails db:create && bundle exec rails db:migrate && bundle exec rails s -b 0.0.0.0"]
