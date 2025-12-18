FROM vllm/vllm-openai:v0.4.2

ENV HF_HOME=/models
ENV TRANSFORMERS_CACHE=/models
ENV HF_HUB_ENABLE_HF_TRANSFER=1
ENV VLLM_LOGGING_LEVEL=INFO

EXPOSE 8000

CMD ["bash", "-lc", "python3 -m vllm.entrypoints.openai.api_server \
  --model mistralai/Mistral-7B-Instruct-v0.3 \
  --dtype float16 \
  --max-model-len 8192 \
  --host 0.0.0.0 \
  --port 8000"]
