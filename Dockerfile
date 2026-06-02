FROM node:20-alpine3.23

RUN apk update && apk add --no-cache python3 py3-pip git build-base pkgconf python3-dev
RUN git clone --branch v2.0b https://github.com/BlinkZer0/Phys-MCP.git /app --single-branch
RUN rm -rf /app/.git
ADD start-phys-mcp.sh /app/start.sh
RUN chmod a+x /app/start.sh
WORKDIR /app
RUN npm install -g pnpm mcp-proxy
RUN python3 -m venv .venv
RUN source .venv/bin/activate && pip install --upgrade pip 
RUN source .venv/bin/activate && pnpm install 
RUN source .venv/bin/activate &&  pip3 install -U mcpo scikit-learn
RUN source .venv/bin/activate && cd packages/python-worker && pip3 install -r requirements.txt
 
RUN pnpm build

ENV LM_BASE_URL=http://localhost:1234/v1
ENV LM_API_KEY=
ENV DEFAULT_MODEL=qwen2.5-coder


CMD [ "/bin/sh", "-c", "./start.sh" ]
