import argparse
import json
from typing import Iterable, List
import requests
import multiprocessing as mp

#MODEL=""
#ADDR=""

def get_model_name(url) :

    # Get model
    response = requests.get(url)
    print(response.text + "\n")
    modelStr = json.loads(response.text)["data"][0]["id"]
    return modelStr
def get_payload(prompt: str ) :
    # Set up information to send
    data = {
            "messages": [
              	{ "role":"system",
                  "content" : "You are a helpful assistant",
                },
                {"role":"user","content": prompt} ],
            "model": modelStr,
            "max_tokens": 400,
            "temperature": 0.2,
           }

    return data 


def post_http_request(prompt: str,
                      api_url: str,
                      modelStr: str,
                      n: int = 1,
                      stream: bool = False, ) -> requests.Response:
    """
    Send (Post) a request to the LLM server.
    """

    headers = {"Content-Type": "application/json"}
    data = get_payload(prompt)

    # Request response
    response = requests.post(api_url, headers=headers, json=data, stream=True)

    return response


def get_response(response: requests.Response) -> List[str]:
    """
    Return text from response
    """

    # Load text
    #data = json.loads(response.content)
    data = response.json()
    #print(str(data))
    output = data["choices"][0]["message"]["content"]
    #output = str(data)
    return output


#APIURL = addr

def post_http_request_mp( prompt: str) -> requests.Response:
    """
    Send (Post) a request to the LLM server.
    """

    # headers = {"User-Agent": "Test Client"}
    headers = {"Content-Type": "application/json"}

    # Set up information to send
    data = get_payload(prompt)

    # Request response
    response = requests.post(ADDR, headers=headers, json=data, stream=True)
    

    return response

if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog='Inference Client',description='Arguments for Client to connect with Inference server', add_help=False)
    parser.add_argument("-p",  dest="port", type=int, default=8080, help="Port")
    parser.add_argument("-h",  dest="host", type=str, default="node1", help="Host name")
    args = parser.parse_args()
    requestList = ["[INST] Tell me what Lincoln Laboratory works on. [/INST]",
               "[INST] Tell me what MIT works on. [/INST]",
               "[INST] Tell me what the Department of Energy works on. [/INST]",
               "[INST] Tell me about computational chemistry. [/INST]"]
    numProcs = len(requestList)
    nodeName = args.host
    port = args.port

    
    global ADDR
    BASEURL= f"http://{nodeName}:{port}"
    
    ADDR = f"{BASEURL}/v1/chat/completions"
    addrModel = f"{BASEURL}/v1/models"

    global MODEL
    MODEL = get_model_name(addrModel)
    print(f" Model Name : {MODEL}")
    print("")
    prompt = "Tell me what Lincoln Laboratory works on."
    response = post_http_request(prompt=prompt, api_url=ADDR, modelStr=MODEL)
    print(get_response(response))

    # Process requests
    with mp.Pool(numProcs) as p:
        outList = p.map(post_http_request_mp, requestList)

    for response in outList:
        print(get_response(response))
        print()

