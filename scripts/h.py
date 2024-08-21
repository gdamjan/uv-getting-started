import httpx

params = {"key1": "value1", "key2": "value2"}
r = httpx.get("https://httpbin.org/get", params=params)
print(r.status_code)
print(r.text)
