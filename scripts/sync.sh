#!/bin/bash

src_dir="../root"
dst_dir="/"

function create_hard_links() {
	local src_path="$1"
	local dst_path="$2"
	
	for item in "$src_path"/*; do
		if [ -d "$item" ]; then
			mkdir -p "${dst_path}${item#$src_path}/"
			create_hard_links "$item" "${dst_path}${item#$src_path}/"
		elif [ -f "$item" ] && [[ ! "$item" =~ \.enc$ ]]; then
			ln "$item" "${dst_path}${item#$src_path}"
		fi
	done
}

create_hard_links "$src_dir" "$dst_dir"