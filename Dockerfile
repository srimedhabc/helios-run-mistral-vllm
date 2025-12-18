FROM vllm/vllm-openai:v0.4.2

ARG HF_TOKEN
ENV HF_TOKEN=${HF_TOKEN}

ENV HF_HOME=/models
ENV TRANSFORMERS_CACHE=/models
ENV HF_HUB_ENABLE_HF_TRANSFER=1

RUN pip install --no-cache-dir huggingface_hub

RUN huggingface-cli download \
    mistralai/Mistral-7B-Instruct-v0.3 \
    --local-dir /models/mistral \
    --local-dir-use-symlinks False

EXPOSE 8000

CMD ["python3", "-m", "vllm.entrypoints.openai.api_server", \
     "--model", "/models/mistral", \
     "--dtype", "float16", \
     "--max-model-len", "8192"]
