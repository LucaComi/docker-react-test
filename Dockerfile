# ------------------ STEP 1 ---------------------------
# I add a tag to it to mark that this is the Builder phase
FROM node:16-alpine as builder
WORKDIR "/app"
COPY package.json . 
RUN npm install
COPY . .
RUN npm run build

# ------------------ STEP 2 ---------------------------
# The second phase can start with simply a new FROM command
FROM nginx 
# I want to copy everything from a different phase this is why i use --from
COPY --from=builder /app/build /usr/share/nginx/html

# When we start nginx container the system will take care of the start command by itself. 
