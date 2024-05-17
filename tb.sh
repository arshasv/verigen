rm a.out
random_string=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 6 | head -n 1)
file_name="output_${random_string}.txt"
iverilog -o halfadder_wav halfadder.v halfadder_tb.v > "$file_name" 2>&1

if [ -s "$file_name" ]; then
	curl --location 'https://verilogcodegen.azurewebsites.net/auth/register' \
	--header 'Content-Type: application/json' \
	--data '{
	  "content": "$(cat "$file_name")"
	}'
else
	vvp halfadder_wav 
fi	

