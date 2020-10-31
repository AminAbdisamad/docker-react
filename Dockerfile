FROM node:14.15.0-alpine3.12 as builder 
WORKDIR "/app"
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# We expose port 80 so that elasticbeanstalk can use this port
EXPOSE 80 
COPY --from=builder app/build usr/share/nginx/html
