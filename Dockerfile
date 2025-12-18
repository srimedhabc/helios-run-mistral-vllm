FROM vllm/vllm-openai:v0.4.2

ENV HF_HOME=/models
ENV TRANSFORMERS_CACHE=/models
ENV HF_HUB_ENABLE_HF_TRANSFER=1

RUN python3 - << 'EOF'
from huggingface_hub import snapshot_download
snapshot_download(
    repo_id="mistralai/Mistral-7B-Instruct-v0.3",
    local_dir="/models/mistral",
    local_dir_use_symlinks=False
)
EOF

EXPOSE 8000

CMD ["python3", "-m", "vllm.entrypoints.openai.api_server", \
     "--model", "/models/mistral", \
     "--dtype", "float16", \
     "--max-model-len", "8192"]
