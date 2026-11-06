from concurrent.futures import ThreadPoolExecutor, as_completed
import requests
import argparse
import json

# Llama.cpp server endpoint (OpenAI-compatible chat completions endpoint)
#BASEURL= f"http://localhost:8080"
#SERVER_URL = f"{BASEURL}/v1/chat/completions"

# List of prompts or conversation inputs to send
PROMPTS = [
    "Explain quantum computing in one sentence.",
    "What are the benefits of local LLMs?",
    "Write a haiku about Python programming.",
    "Give me a quick recipe for scrambled eggs.",
    "What is the capital of France?",
]

def get_model_name(host,port) :

    url = f"http://{host}:{port}/v1/models"
    
    # Get model
    response = requests.get(url)
    print(response.text + "\n")
    modelStr = json.loads(response.text)["data"][0]["id"]
    return modelStr

def send_inference_request(url: str, modelname:str, prompt: str, index: int) -> dict:
  """Sends a single chat completion request to the llama.cpp server."""
  payload = {
      "model": modelname,  # llama.cpp usually accepts any model string
      "messages": [
          {
              "role": "system",
              "content": "You are a concise, helpful assistant.",
          },
          {"role": "user", "content": prompt},
      ],
      "max_tokens": 150,
      "temperature": 0.7,
  }

  headers = {"Content-Type": "application/json"}

  try:
    response = requests.post(url, json=payload, headers=headers)
    response.raise_for_status()
    data = response.json()
    reply = data["choices"][0]["message"]["content"].strip()
    return {"index": index, "prompt": prompt, "reply": reply, "status": "success"}
  except Exception as e:
    return {"index": index, "prompt": prompt, "reply": str(e), "status": "error"}


def main():
  parser = argparse.ArgumentParser(prog='Inference Client',description='Arguments for Client to connect with Inference server', add_help=False)
  parser.add_argument("-p",  dest="port", type=int, default=8080, help="Port")
  parser.add_argument("-h",  dest="host", type=str, default="node1", help="Host name")
  args = parser.parse_args()

  host=args.host
  port=args.port

  modelName= get_model_name(host,port)
  BASEURL=f"http://{host}:{port}"
  SERVER_URL = f"{BASEURL}/v1/chat/completions"
  # Max workers controls how many requests are fired concurrently
  max_concurrent_requests = 3

  print(f"Sending {len(PROMPTS)} requests to {SERVER_URL}...")

  with ThreadPoolExecutor(max_workers=max_concurrent_requests) as executor:
    # Submit all tasks
    future_to_prompt = {
        executor.submit(send_inference_request, SERVER_URL, modelName,prompt, i): prompt
        for i, prompt in enumerate(PROMPTS)
    }

    # Process results as they complete
    for future in as_completed(future_to_prompt):
      result = future.result()
      if result["status"] == "success":
        print(f"\n[Request #{result['index']}] Prompt: {result['prompt']}")
        print(f"Reply: {result['reply']}")
      else:
        print(
            f"\n[Request #{result['index']}] Failed with error:"
            f" {result['reply']}"
        )


if __name__ == "__main__":
  main()

