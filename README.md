# Docker Node.js Express App

A minimal Express server, containerized with Docker. It responds with `Hello Farhana Sharna` on `/`.

## Project structure

```
.
├── Dockerfile          # Image build instructions (node:20-alpine)
├── .dockerignore       # Files excluded from the image build context
├── index.js            # Express server (port 5000 by default)
├── package.json        # Dependencies (express)
└── package-lock.json   # Locked dependency versions
```

## Prerequisites

- Node.js 20+ and npm (for local runs)
- Docker (for container runs)

Verify:

```bash
node -v
npm -v
docker --version
```

## Workflow

### 1. Set up the project (one time)

```bash
cd ~/projects/docker
npm init -y
npm install express
```

### 2. Run locally (without Docker)

```bash
node index.js
```

Open http://localhost:5000. Use a different port with `PORT=3000 node index.js`.

### 3. Build the Docker image

```bash
sudo docker build .
```

What the Dockerfile does:

1. Starts from `node:20-alpine`.
2. Sets the working directory to `/user/src/app`.
3. Copies `package.json` and `package-lock.json` first, so the dependency layer is cached.
4. Runs `npm ci --omit=dev` for a reproducible, production-only install.
5. Copies the rest of the source, exposes port 5000, and starts `node index.js`.

### 4. Run the container

```bash
sudo docker run -p 5000:5000 [imageId]
```

`-p 5000:5000` maps host port 5000 to container port 5000. To use another host port, e.g. 8080: `-p 8080:5000`.



## Notes

- `.dockerignore` keeps local `node_modules` out of the image, so dependencies are installed fresh inside the container.
- If `npm ci` fails, make sure `package-lock.json` is in sync with `package.json` (`npm install` regenerates it).
