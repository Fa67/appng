/*
 * Copyright 2011-2017 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.appng.tools.file;

import java.io.File;
import java.io.FilenameFilter;
import java.util.regex.Pattern;

/**
 * 
 * @author herlitzius.matthias
 */
public class FilePrefixFilter implements FilenameFilter {

	private final String prefix;
	private final String pattern;

	public FilePrefixFilter(String prefix) {
		this.prefix = prefix;
		this.pattern = null;
	}

	public FilePrefixFilter(Pattern pattern) {
		this.prefix = null;
		this.pattern = pattern.toString();
	}

	public boolean accept(File dir, String name) {
		if (prefix != null) {
			return name.startsWith(prefix);
		} else if (pattern != null) {
			return name.matches(pattern);
		} else {
			return false;
		}
	}
}
