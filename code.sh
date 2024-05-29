#!/bin/bash

random_string=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 6 | head -n 1)
file_name="output_${random_string}.txt"
iverilog halfadder.v > "$file_name" 2>&1

if [ -s "$file_name" ]; then
	curl --location 'https://genesisforge.openai.azure.com/openai/deployments/gpt-35-turbo/chat/completions?api-version=2023-03-15-preview&api-key=0efc6bbadac9465381b4886e2698b420' \
	--header 'Content-Type: application/json' \
	--data '{
 	  "messages": [
    	    {
      		"role": "system",
      		"content": "You are an AI assistant that helps people find information."
    	    },
    	    {
        	"role" : "user",
        	"content": "$(cat "$file_name")"
    	    }
  	  ],
  	  "temperature": 0.7,
          "top_p": 0.95,
  	  "frequency_penalty": 0,
  	  "presence_penalty": 0,
  	  "max_tokens": 800,
  	  "stop": null
        }'
else
	curl --location 'https://verilogcodegen.azurewebsites.net/auth/register' \
        --header 'Content-Type: application/json' \
        --data '{
	  "content": "Generate corresponding testbench for the verilog code with $dumpfile and $dumpvars"
	}'
fi	
