FROM vllm/vllm-openai:v0.4.2

WORKDIR /app

# Hugging Face token at build time
ARG HF_TOKEN
ENV HF_TOKEN=${HF_TOKEN}

RUN apt-get update && apt-get install -y git

# Login + download model ONCE
RUN huggingface-cli login --token $HF_TOKEN && \
    huggingface-cli download \
    mistralai/Mistral-7B-Instruct-v0.3 \
    --local-dir /models/mistral \
    --local-dir-use-symlinks False

COPY handler.py .

CMD ["python3", "handler.py"]

