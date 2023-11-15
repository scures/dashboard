# ---- Base Node ----
FROM node:16-alpine AS base
WORKDIR /src

#  COPY package.json yarn.lock ./
COPY package.json ./

# ---- Dependencies ----
FROM base AS dependencies
RUN apk update && apk upgrade
# RUN yarn install --production --pure-lockfile
RUN yarn install --production
COPY . .

# ---- Build ----
FROM dependencies AS build
# RUN yarn install --pure-lockfile
RUN yarn install
ARG API
ENV API=$API
RUN yarn build

# ---- Release ----
FROM node:16-alpine AS release
WORKDIR /src
COPY --from=dependencies /src/node_modules ./node_modules
COPY --from=build /src .
ARG API
ENV API=$API
EXPOSE 8005
ENTRYPOINT ["yarn"]
CMD ["start"]
