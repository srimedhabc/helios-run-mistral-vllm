import runpod
from vllm import LLM, SamplingParams

print("🚀 Starting worker...")

llm = LLM(
    model="/models/mistral",
    dtype="float16",
    max_model_len=8192
)

print("✅ Model loaded")

def handler(event):
    prompt = event["input"].get("prompt")
    if not prompt:
        return {"error": "Prompt is required"}

    params = SamplingParams(
        temperature=0.7,
        max_tokens=256
    )

    output = llm.generate([prompt], params)
    return {
        "output": output[0].outputs[0].text.strip()
    }

runpod.serverless.start({"handler": handler})

