#!/usr/bin/python3

import os

duplicated_path = os.getenv("PATH")
duplicated_path = duplicated_path.split(":")
final_path = []
for path in duplicated_path:
    if not path in final_path:
        final_path.append(path)

for value in final_path:
    print(value)
