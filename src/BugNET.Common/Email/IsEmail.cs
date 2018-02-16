﻿namespace BugNET.Common
{
	#region Using Statements

	using System;
	using System.Collections.Generic;
	using System.Text.RegularExpressions;

	#endregion

	/// <summary>
	/// PORTED TO C# BY SEAN OTTEY
	/// <para>To validate an email address according to RFCs 5321, 5322 and others</para>
	/// <para>Copyright © 2008-2010, Dominic Sayers Test schema documentation Copyright © 2010, Daniel Marschall All rights reserved.</para>
	/// <para>Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
	///      - Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. - Redistributions in binary form must
	///      reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution. -
	///      Neither the name of Dominic Sayers nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior
	///      written permission.
	/// </para>
	/// <para>THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
	///      OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
	///      INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
	///      BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
	///      ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
	/// </para>
	/// <para>
	///      @package com.dominicsayers.isemail
	///      @author Dominic Sayers &lt;dominic@sayers.cc&gt;
	///              Translated from PHP into Java by Daniel Marschall [www.daniel-marschall.de]
	///      @copyright 2008-2010 Dominic Sayers; Java-Translation 2010 by Daniel
	///                 Marschall
	///      @license http://www.opensource.org/licenses/bsd-license.php BSD License
	///      @link http://www.dominicsayers.com/isemail
	///      @version 2010-10-18. Java-Translation of isemail.php:r68.
	/// </para>
	/// </summary>
	/// <remarks>Rob Moloney, 27/01/2018.</remarks>
	public class IsEMail
	{
		#region Public Properties

		/// <summary>Gets information describing the result.</summary>
		/// <value>Information describing the result.</value>
		public List<string> ResultInfo { get; private set; }

		#endregion Public Properties

		#region Public Methods

		/// <summary>
		///  Checks that an email address conforms to RFCs 5321, 5322 and others. With
		/// verbose information.
		/// @param email
		/// The email address to check
		/// @param checkDNS
		/// If true then a DNS check for A and MX records will be made
		/// @return Result-Object of the email analysis.
		/// @throws DNSLookupException
		/// Is thrown if an internal error in the DNS lookup appeared.
		/// </summary>
		/// <remarks>Rob Moloney, 27/01/2018.</remarks>
		/// <param name="email">The email.</param>
		/// <returns>True if the email is valid, false if not.</returns>
		public bool IsEmailValid(string email)
		{
			this.ResultInfo = new List<string>();

			if (email == null)
			{
				email = string.Empty;
			}

			/*
			 Check that $email is a valid address. Read the following RFCs to
			 understand the constraints:
			 (http://tools.ietf.org/html/rfc5321)
			 (http://tools.ietf.org/html/rfc5322)
			 (http://tools.ietf.org/html/rfc4291#section-2.2)
			 (http://tools.ietf.org/html/rfc1123#section-2.1)
			 (http://tools.ietf.org/html/rfc3696) (guidance only)

			 the upper limit on address lengths should normally be considered to
			 be 254
			 (http://www.rfc-editor.org/errata_search.php?rfc=3696)
			 NB My erratum has now been verified by the IETF so the correct answer
			 is 254

			 The maximum total length of a reverse-path or forward-path is 256
			 characters (including the punctuation and element separators)
			 (http://tools.ietf.org/html/rfc5321#section-4.5.3.1.3)
			 NB There is a mandatory 2-character wrapper round the actual address
			*/
			int emailLength = email.Length;

			// revision 1.17: Max length reduced to 254 (see above)
			if (emailLength > 254)
			{
				this.ResultInfo.Add(
					@"
Email is too long.

The maximum total length of a reverse-path or forward-path is 256
characters (including the punctuation and element separators)
(http://tools.ietf.org/html/rfc5321#section-4.5.3.1.3)
");
				return false;
			}

			// Contemporary email addresses consist of a "local part" separated from
			// a "domain part" (a fully-qualified domain name) by an at-sign ("@").
			// (http://tools.ietf.org/html/rfc3696#section-3)
			int atIndex = email.LastIndexOf('@');

			if (atIndex == -1)
			{
				this.ResultInfo.Add(
					@"
			Email is too long.

			Contemporary email addresses consist of a ""local part"" separated from
			a ""domain part"" (a fully-qualified domain name) by an at-sign (""@"").
			(http://tools.ietf.org/html/rfc3696#section-3)
			");
				return false;
			}

			if (atIndex == 0)
			{
				this.ResultInfo.Add(
					@"
			Email is too long.

			Contemporary email addresses consist of a ""local part"" separated from
			a ""domain part"" (a fully-qualified domain name) by an at-sign (""@"").
			(http://tools.ietf.org/html/rfc3696#section-3)
			");
				return false;
			}

			if (atIndex == emailLength - 1)
			{
				this.ResultInfo.Add(
					@"
			Email is too long.

			Contemporary email addresses consist of a ""local part"" separated from
			a ""domain part"" (a fully-qualified domain name) by an at-sign (""@"").
			(http://tools.ietf.org/html/rfc3696#section-3)
			");
				return false;
			}

			// Sanitize comments
			// - remove nested comments, quotes and dots in comments
			// - remove parentheses and dots from quoted strings
			var braceDepth = 0;
			var inQuote = false;
			var escapeThisChar = false;

			for (var i = 0; i < emailLength; ++i)
			{
				char charX = email.ToCharArray()[i];
				var replaceChar = false;

				if (charX == '\\')
				{
					escapeThisChar = !escapeThisChar; // Escape the next character?
				}
				else
				{
					switch (charX)
					{
						case '(':
							if (escapeThisChar)
							{
								replaceChar = true;
							}
							else
							{
								if (inQuote)
								{
									replaceChar = true;
								}
								else
								{
									replaceChar |= braceDepth++ > 0;
								}
							}

							break;
						case ')':
							if (escapeThisChar)
							{
								replaceChar = true;
							}
							else
							{
								if (inQuote)
								{
									replaceChar = true;
								}
								else
								{
									replaceChar |= --braceDepth > 0;

									if (braceDepth < 0)
									{
										braceDepth = 0;
									}
								}
							}

							break;
						case '"':
							if (escapeThisChar)
							{
								replaceChar = true;
							}
							else
							{
								if (braceDepth == 0)
								{
									// Are we inside a quoted string?
									inQuote = !inQuote;
								}
								else
								{
									replaceChar = true;
								}
							}

							break;
						case '.': // Dots don't help us either
							if (escapeThisChar)
							{
								replaceChar = true;
							}
							else
							{
								replaceChar |= braceDepth > 0;
							}

							break;
					}

					escapeThisChar = false;

					if (replaceChar)
					{
						// Replace the offending character with something harmless
						// revision 1.12: Line above replaced because PHPLint
						// doesn't like that syntax
						email = ReplaceCharAt(email, i, 'x');
					}
				}
			}

			string localPart = email.Substring(0, atIndex);
			string domain = email.Substring(atIndex + 1);

			// Folding white space
			const string Fws = "(?:(?:(?:[ \\t]*(?:\\r\\n))?[ \\t]+)|(?:[ \\t]+(?:(?:\\r\\n)[ \\t]+)*))";

			// Let's check the local part for RFC compliance...
			// local-part = dot-atom / quoted-string / obs-local-part
			// obs-local-part = word *("." word)
			// (http://tools.ietf.org/html/rfc5322#section-3.4.1)
			// Problem: need to distinguish between "first.last" and "first"."last"
			// (i.e. one element or two). And I suck at regular expressions.
			var regex = new Regex("(?m)\\.(?=(?:[^\\\"]*\\\"[^\\\"]*\\\")*(?![^\\\"]*\\\"))");
			string[] dotArray = regex.Split(localPart);
			var partLength = 0;

			foreach (string element in dotArray)
			{
				string workingElement = element; // for use in our for loop, can't work on a foreach target SCO-04152011

				// Remove any leading or trailing FWS
				var repRegex = new Regex($"^{Fws}|{Fws}$");
				string newElement = repRegex.Replace(workingElement, string.Empty);

				if (!workingElement.Equals(newElement, StringComparison.OrdinalIgnoreCase))
				{
					// FWS is unlikely in the real world
					this.ResultInfo.Add(
						@"
				Folding White Space

				local-part = dot-atom / quoted-string / obs-local-part
				obs-local-part = word *(""."" word)
(http://tools.ietf.org/html/rfc5322#section-3.4.1)
			");
				}

				workingElement = newElement; // version 2.3: Warning condition added

				int elementLength = newElement.Length;

				if (elementLength == 0)
				{
					// Can't have empty element (consecutive dots or
					// dots at the start or end)
					this.ResultInfo.Add(
						@"
				Can't have empty element (consecutive dots or
				dots at the start or end)
				(http://tools.ietf.org/html/rfc5322#section-3.4.1)
			");
					return false;
				}

				// revision 1.15: Speed up the test and get rid of
				// "uninitialized string offset" notices from PHP

				// We need to remove any valid comments (i.e. those at the start or
				// end of the element)
				if (workingElement.Substring(0).Equals("(", StringComparison.OrdinalIgnoreCase))
				{
					// Comments are unlikely in the real world
					// return_status = IsEMailResult.ISEMAIL_COMMENTS;

					// version 2.0: Warning condition added
					int indexBrace = workingElement.IndexOf(")", StringComparison.OrdinalIgnoreCase);

					if (indexBrace != -1)
					{
						var pregMatch = new Regex("(?<!\\\\)[\\(\\)]");
						if (pregMatch.Matches(workingElement.Substring(1, indexBrace - 1)).Count > 0)
						{
							// Illegal characters in comment
							this.ResultInfo.Add(
								@"
							Illegal characters in comment
						");
							return false;
						}

						workingElement = workingElement.Substring(indexBrace + 1, elementLength - indexBrace - 1);
						elementLength = workingElement.Length;
					}
				}

				if (workingElement.Substring(elementLength - 1).Equals(")", StringComparison.OrdinalIgnoreCase))
				{
					// Comments are unlikely in the real world
					// return_status = IsEMailResult.ISEMAIL_COMMENTS;

					// version 2.0: Warning condition added
					int indexBrace = workingElement.LastIndexOf("(", StringComparison.OrdinalIgnoreCase);

					if (indexBrace != -1)
					{
						var pregMatch = new Regex("(?<!\\\\)(?:[\\(\\)])");

						if (pregMatch.Matches(workingElement.Substring(indexBrace + 1, elementLength - indexBrace - 2)).Count > 0)
						{
							// Illegal characters in comment
							this.ResultInfo.Add(
								@"
							Illegal characters in comment
						");
							return false;
						}

						workingElement = workingElement.Substring(0, indexBrace);
						elementLength = workingElement.Length;
					}
				}

				// Remove any remaining leading or trailing FWS around the element
				// (having removed any comments)
				var fwsRegex = new Regex("^" + Fws + "|" + Fws + "$");

				newElement = fwsRegex.Replace(workingElement, string.Empty);

				//// FWS is unlikely in the real world
				// if (!working_element.equals(new_element))
				// return_status = IsEMailResult.ISEMAIL_FWS;
				workingElement = newElement;

				// version 2.0: Warning condition added

				// What's left counts towards the maximum length for this part
				if (partLength > 0)
				{
					partLength++; // for the dot
				}

				partLength += workingElement.Length;

				// Each dot-delimited component can be an atom or a quoted string
				// (because of the obs-local-part provision)
				var quotRegex = new Regex("(?s)^\"(?:.)*\"$");
				if (quotRegex.Matches(workingElement).Count > 0)
				{
					// Quoted-string tests:
					// Quoted string is unlikely in the real world
					// return_status = IsEMailResult.ISEMAIL_QUOTEDSTRING;
					// version 2.0: Warning condition added
					// Remove any FWS
					// A warning condition, but we've already raised
					// ISEMAIL_QUOTEDSTRING
					var newRepRegex = new Regex("(?<!\\\\)" + Fws);
					workingElement = newRepRegex.Replace(workingElement, string.Empty);

					// My regular expression skills aren't up to distinguishing
					// between \" \\" \\\" \\\\" etc.
					// So remove all \\ from the string first...
					var slashRegex = new Regex("\\\\\\\\");
					workingElement = slashRegex.Replace(workingElement, string.Empty);

					var quot2Regex = new Regex("(?<!\\\\|^)[\"\\r\\n\\x00](?!$)|\\\\\"$|\"\"");
					if (quot2Regex.Matches(workingElement).Count > 0)
					{
						// ", CR, LF and NUL must be escaped
						// version 2.0: allow ""@example.com because it's
						// technically valid
						this.ResultInfo.Add(
							@"
							"", CR, LF and NUL must be escaped
						");
						return false;
					}
				}
				else
				{
					// Unquoted string tests:
					// Period (".") may...appear, but may not be used to start or
					// end the
					// local part, nor may two or more consecutive periods appear.
					// (http://tools.ietf.org/html/rfc3696#section-3)
					// A zero-length element implies a period at the beginning or
					// end of the
					// local part, or two periods together. Either way it's not
					// allowed.
					if (string.IsNullOrEmpty(workingElement))
					{
						// Dots in wrong place
						this.ResultInfo.Add(
							@"
						A zero-length element implies a period at the beginning or
						end of the local part, or two periods together. Either way it's not
						allowed.
					");
						return false;
					}

					// Any ASCII graphic (printing) character other than the
					// at-sign ("@"), backslash, double quote, comma, or square
					// brackets may
					// appear without quoting. If any of that list of excluded
					// characters
					// are to appear, they must be quoted
					// (http://tools.ietf.org/html/rfc3696#section-3)
					// Any excluded characters? i.e. 0x00-0x20, (, ), <, >, [, ], :,
					// ;, @, \, comma, period, "
					var quot3Regex = new Regex("[\\x00-\\x20\\(\\)<>\\[\\]:;@\\\\,\\.\"]");

					if (quot3Regex.Matches(workingElement).Count > 0)
					{
						// These characters must be in a quoted string
						this.ResultInfo.Add(
							@"
						 Any ASCII graphic (printing) character other than the
						 at-sign (""@""), backslash, double quote, comma, or square
						 brackets may appear without quoting. If any of that list of excluded
						 characters are to appear, they must be quoted
						 (http://tools.ietf.org/html/rfc3696#section-3)
						");
						return false;
					}

					// Regex quot4Regex = new Regex("^\\w+");
					// if (quot4Regex.Matches(working_element).Count == 0)
					// {
					// // First character is an odd one
					// return_status = IsEMailResult.ISEMAIL_UNLIKELYINITIAL;
					// }
				}
			}

			if (partLength > 64)
			{
				// Local part must be 64 characters or less
				this.ResultInfo.Add(
					@"
				Local part must be 64 characters or less
			");
				return false;
			}

			// Now let's check the domain part...

			// The domain name can also be replaced by an IP address in square
			// brackets
			// (http://tools.ietf.org/html/rfc3696#section-3)
			// (http://tools.ietf.org/html/rfc5321#section-4.1.3)
			// (http://tools.ietf.org/html/rfc4291#section-2.2)
			// IPv4 is the default format for address literals. Alternative formats
			// can
			// be defined. At the time of writing only IPv6 has been defined as an
			// alternative format. Non-IPv4 formats must be tagged to show what type
			// of address literal they are. The registry of current tags is here:
			// http://www.iana.org/assignments/address-literal-tags
			if (new Regex("^\\[(.)+]$").Matches(domain).Count == 1)
			{
				//// It's an address-literal
				//// Quoted string is unlikely in the real world
				// return_status = IsEMailResult.ISEMAIL_ADDRESSLITERAL;

				// version 2.0: Warning condition added
				string addressLiteral = domain.Substring(1, domain.Length - 2);

				string ipv6;
				var groupMax = 8;

				// revision 2.1: new IPv6 testing strategy
				var colon = ":"; // Revision 2.7: Daniel Marschall's new

				// IPv6 testing strategy
				const string DoubleColon = "::";
				const string Ipv6Tag = "IPv6:";

				// Extract IPv4 part from the end of the address-literal (if there
				// is one)
				var splitRegex = new Regex("\\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$");

				MatchCollection matchesIP1 = splitRegex.Matches(addressLiteral);
				if (matchesIP1.Count > 0)
				{
					int index = addressLiteral.LastIndexOf(matchesIP1[0].Value, StringComparison.OrdinalIgnoreCase);

					if (index == 0)
					{
						// Nothing there except a valid IPv4 address, so...
						return true;

						// version 2.0: return warning if one is set
					}

					// - // Assume it's an attempt at a mixed address (IPv6 +
					// IPv4)
					// - if ($addressLiteral[$index - 1] !== ':') return
					// IsEMailResult.ISEMAIL_IPV4BADPREFIX; // Character
					// preceding IPv4 address must be ':'
					// revision 2.1: new IPv6 testing strategy
					if (!addressLiteral.Substring(0, 5).Equals(Ipv6Tag, StringComparison.OrdinalIgnoreCase))
					{
						// RFC5321 section 4.1.3
						this.ResultInfo.Add(
							@"
							Character preceding IPv4 address must be ':'
							RFC5321 section 4.1.3	
						");
						return false;
					}

					// -
					// - $IPv6 = substr($addressLiteral, 5, ($index === 7) ? 2 :
					// $index - 6);
					// - $groupMax = 6;
					// revision 2.1: new IPv6 testing strategy
					ipv6 = addressLiteral.Substring(5, index - 5) + "0000:0000"; // Convert IPv4 part to IPv6 format
				}
				else
				{
					// It must be an attempt at pure IPv6
					if (!addressLiteral.Substring(0, 5).Equals(Ipv6Tag, StringComparison.OrdinalIgnoreCase))
					{
						// RFC5321 section 4.1.3
						this.ResultInfo.Add(
							@"
							Invalid IPV6 address
							RFC5321 section 4.1.3	
						");
						return false;
					}

					ipv6 = addressLiteral.Substring(5);

					// - $groupMax = 8;
					// revision 2.1: new IPv6 testing strategy
				}

				// Revision 2.7: Daniel Marschall's new IPv6 testing strategy
				var split2Regex = new Regex(colon);
				string[] matchesIP = split2Regex.Split(ipv6);
				int groupCount = matchesIP.Length;
				int currIndex = ipv6.IndexOf(DoubleColon, StringComparison.OrdinalIgnoreCase);

				if (currIndex == -1)
				{
					// We need exactly the right number of groups
					if (groupCount != groupMax)
					{
						// RFC5321 section 4.1.3
						this.ResultInfo.Add(
							@"
							Invalid IPV6 groupcount
							RFC5321 section 4.1.3	
						");
						return false;
					}
				}
				else
				{
					if (currIndex != ipv6.LastIndexOf(DoubleColon, StringComparison.OrdinalIgnoreCase))
					{
						// More than one '::'
						this.ResultInfo.Add(
							@"
							IPV6 double double colon present
							RFC5321 section 4.1.3	
						");
						return false;
					}

					if ((currIndex == 0) || (currIndex == ipv6.Length - 2))
					{
						groupMax++; // RFC 4291 allows :: at the start or end of an
					}

					// address with 7 other groups in addition
					if (groupCount > groupMax)
					{
						// Too many IPv6 groups in address
						this.ResultInfo.Add(
							@"
							Too many groups in section
							RFC5321 section 4.1.3	
						");
						return false;
					}

					if (groupCount == groupMax)
					{
						// Eliding a single group with :: is deprecated by RFCs 5321 & 5952
						// & 5952
						this.ResultInfo.Add(@"Eliding a single group with :: is deprecated by RFCs 5321 & 5952");
					}
				}

				// Check for single : at start and end of address
				// Revision 2.7: Daniel Marschall's new IPv6 testing strategy
				if (ipv6.StartsWith(colon, StringComparison.OrdinalIgnoreCase)
					&& !ipv6.StartsWith(DoubleColon, StringComparison.OrdinalIgnoreCase))
				{
					// Address starts with a single colon
					this.ResultInfo.Add(
						@"
					IPV6 must start with a single colon
					RFC5321 section 4.1.3	
						");
					return false;
				}

				if (ipv6.EndsWith(colon, StringComparison.OrdinalIgnoreCase)
					&& !ipv6.EndsWith(DoubleColon, StringComparison.OrdinalIgnoreCase))
				{
					// Address ends with a single colon
					this.ResultInfo.Add(
						@"
					IPV6 must end with a single colon
					RFC5321 section 4.1.3	
						");
					return false;
				}

				// Check for unmatched characters
				foreach (string s in matchesIP)
				{
					var goodStuff = new Regex("^[0-9A-Fa-f]{0,4}$");
					if (goodStuff.Matches(s).Count == 0)
					{
						this.ResultInfo.Add(
							@"
					IPV6 address contains bad characters
					RFC5321 section 4.1.3	
						");
						return false;
					}
				}

				// It's a valid IPv6 address, so...
				return true;

				// revision 2.1: bug fix: now correctly return warning status
			}
			else
			{
				// It's a domain name...

				// The syntax of a legal Internet host name was specified in RFC-952
				// One aspect of host name syntax is hereby changed: the
				// restriction on the first character is relaxed to allow either a
				// letter or a digit.
				// (http://tools.ietf.org/html/rfc1123#section-2.1)
				// NB RFC 1123 updates RFC 1035, but this is not currently apparent
				// from reading RFC 1035.
				// Most common applications, including email and the Web, will
				// generally not
				// permit...escaped strings
				// (http://tools.ietf.org/html/rfc3696#section-2)
				// the better strategy has now become to make the
				// "at least one period" test,
				// to verify LDH conformance (including verification that the
				// apparent TLD name
				// is not all-numeric)
				// (http://tools.ietf.org/html/rfc3696#section-2)
				// Characters outside the set of alphabetic characters, digits, and
				// hyphen MUST NOT appear in domain name
				// labels for SMTP clients or servers
				// (http://tools.ietf.org/html/rfc5321#section-4.1.2)
				// RFC5321 precludes the use of a trailing dot in a domain name for
				// SMTP purposes
				// (http://tools.ietf.org/html/rfc5321#section-4.1.2)
				var split2Regex = new Regex("(?m)\\.(?=(?:[^\\\"]*\\\"[^\\\"]*\\\")*(?![^\\\"]*\\\"))");
				dotArray = split2Regex.Split(domain);
				partLength = 0;

				// Since we use 'element' after the foreach
				// loop let's make sure it has a value
				string lastElement = string.Empty;

				// revision 1.13: Line above added because PHPLint now checks for
				// Definitely Assigned Variables
				if (dotArray.Length == 1)
				{
					this.ResultInfo.Add(@"The mail host probably isn't a TLD");
				}

				// version 2.0: downgraded to a warning
				foreach (string element in dotArray)
				{
					string workingElement = element;
					lastElement = element;

					// Remove any leading or trailing FWS
					var newReg = new Regex("^" + Fws + "|" + Fws + "$");
					string newElement = newReg.Replace(workingElement, string.Empty);

					if (!element.Equals(newElement, StringComparison.OrdinalIgnoreCase))
					{
						this.ResultInfo.Add(@"FWS is unlikely in the real world");
					}

					workingElement = newElement;

					// version 2.0: Warning condition added
					int elementLength = workingElement.Length;

					// Each dot-delimited component must be of type atext
					// A zero-length element implies a period at the beginning or
					// end of the
					// local part, or two periods together. Either way it's not
					// allowed.
					if (elementLength == 0)
					{
						// Dots in wrong place
						this.ResultInfo.Add(
							@"
				 Each dot-delimited component must be of type atext
				 A zero-length element implies a period at the beginning or
				 end of the
				 local part, or two periods together. Either way it's not
				 allowed.
						");
						return false;
					}

					// revision 1.15: Speed up the test and get rid of
					// "uninitialized string offset" notices from PHP

					// Then we need to remove all valid comments (i.e. those at the
					// start or end of the element
					if (workingElement.Substring(0, 1).Equals("(", StringComparison.OrdinalIgnoreCase))
					{
						this.ResultInfo.Add(@"Comments are unlikely in the real world");

						// version 2.0: Warning condition added
						int indexBrace = workingElement.IndexOf(")", StringComparison.OrdinalIgnoreCase);

						if (indexBrace != -1)
						{
							var comments1Regex = new Regex(@"(?<!\\)[\(\)]");

							if (comments1Regex.Matches(workingElement.Substring(1, indexBrace - 1)).Count > 0)
							{
								// revision 1.17: Fixed name of constant (also
								// spotted by turboflash - thanks!)
								// Illegal characters in comment
								this.ResultInfo.Add(
									@"
							Illegal characters in comment
						");
								return false;
							}

							workingElement = workingElement.Substring(indexBrace + 1, elementLength - indexBrace - 1);
							elementLength = workingElement.Length;
						}
					}

					if (workingElement.Substring(elementLength - 1, 1).Equals(")", StringComparison.OrdinalIgnoreCase))
					{
						// Comments are unlikely in the real world
						// return_status = IsEMailResult.ISEMAIL_COMMENTS;

						// version 2.0: Warning condition added
						int indexBrace = workingElement.LastIndexOf("(", StringComparison.OrdinalIgnoreCase);

						if (indexBrace != -1)
						{
							var commentRegex = new Regex("(?<!\\\\)(?:[\\(\\)])");

							if (commentRegex.Matches(workingElement.Substring(indexBrace + 1, elementLength - indexBrace - 2)).Count > 0)
							{
								// revision 1.17: Fixed name of constant (also
								// spotted by turboflash - thanks!)
								// Illegal characters in comment
								this.ResultInfo.Add(
									@"
							Illegal characters in comment
						");
								return false;
							}

							workingElement = workingElement.Substring(0, indexBrace);
							elementLength = workingElement.Length;
						}
					}

					// Remove any leading or trailing FWS around the element (inside
					// any comments)
					var repRegex = new Regex("^" + Fws + "|" + Fws + "$");

					newElement = repRegex.Replace(workingElement, string.Empty);

					// if (!element.equals(new_element))
					// {
					// // FWS is unlikely in the real world
					// return_status = IsEMailResult.ISEMAIL_FWS;
					// }
					workingElement = newElement;

					// version 2.0: Warning condition added

					// What's left counts towards the maximum length for this part
					if (partLength > 0)
					{
						partLength++; // for the dot
					}

					partLength += workingElement.Length;

					// The DNS defines domain name syntax very generally -- a
					// string of labels each containing up to 63 8-bit octets,
					// separated by dots, and with a maximum total of 255
					// octets.
					// (http://tools.ietf.org/html/rfc1123#section-6.1.3.5)
					if (elementLength > 63)
					{
						// Label must be 63 characters or less
						this.ResultInfo.Add(
							@"
				 The DNS defines domain name syntax very generally -- a
				 string of labels each containing up to 63 8-bit octets,
				 separated by dots, and with a maximum total of 255
				 octets.
				 (http://tools.ietf.org/html/rfc1123#section-6.1.3.5)
						");
						return false;
					}

					// Any ASCII graphic (printing) character other than the
					// at-sign ("@"), backslash, double quote, comma, or square
					// brackets may
					// appear without quoting. If any of that list of excluded
					// characters
					// are to appear, they must be quoted
					// (http://tools.ietf.org/html/rfc3696#section-3)
					// If the hyphen is used, it is not permitted to appear at
					// either the beginning or end of a label.
					// (http://tools.ietf.org/html/rfc3696#section-2)
					// Any excluded characters? i.e. 0x00-0x20, (, ), <, >, [, ], :,
					// ;, @, \, comma, period, "
					var badChars = new Regex("[\\x00-\\x20\\(\\)<>\\[\\]:;@\\\\,\\.\"]|^-|-$");
					if (badChars.Matches(workingElement).Count > 0)
					{
						// Illegal character in domain name
						this.ResultInfo.Add(
							@"
					Illegal character in domain name
						");
						return false;
					}
				}

				if (partLength > 255)
				{
					// Domain part must be 255 characters or less
					// (http://tools.ietf.org/html/rfc1123#section-6.1.3.5)
					this.ResultInfo.Add(
						@"
				 Domain part must be 255 characters or less
				 (http://tools.ietf.org/html/rfc1123#section-6.1.3.5)
						");
					return false;
				}

				var foo = new Regex("^[0-9]+$");
				if (foo.Matches(lastElement).Count > 0)
				{
					this.ResultInfo.Add(
						@"TLD probably isn't all-numeric
				(http://www.apps.ietf.org/rfc/rfc3696.html#sec-2)
				");

					// version 2.0: Downgraded to a warning
				}
			}

			// Eliminate all other factors, and the one which remains must be the
			// truth. (Sherlock Holmes, The Sign of Four)
			return true;
		}

		#endregion Public Methods

		#region Private Methods

		/// <summary>
		/// Replaces a char in a String
		/// <para>
		/// @param s
		/// The input string
		/// @param pos
		/// The position of the char to be replaced
		/// @param c
		/// The new char
		/// @return The new String
		/// @see Source: http://www.rgagnon.com/javadetails/java-0030.html
		/// </para></summary>
		/// <remarks>Rob Moloney, 28/01/2018.</remarks>
		/// <param name="s">The string.</param>
		/// <param name="pos">The position.</param>
		/// <param name="c">The character.</param>
		/// <returns>A string.</returns>
		private static string ReplaceCharAt(string s, int pos, char c)
		{
			return s.Substring(0, pos) + c + s.Substring(pos + 1);
		}

		#endregion Private Methods
	}
}