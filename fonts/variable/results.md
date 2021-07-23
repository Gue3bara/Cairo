## Fontbakery report

Fontbakery version: 0.8.0

<details>
<summary><b>[3] Cairo[slnt,wght].ttf</b></summary>
<details>
<summary>🔥 <b>FAIL:</b> Check variable font instances have correct names</summary>

* [com.google.fonts/check/varfont_instance_names](https://font-bakery.readthedocs.io/en/latest/fontbakery/profiles/googlefonts.html#com.google.fonts/check/varfont_instance_names)

* 🔥 **FAIL** Following instances are not supported: 
	- ExtraLight Slant Right
	- Light Slant Right
	- Slant Right
	- Medium Slant Right
	- SemiBold Slant Right
	- Bold Slant Right
	- ExtraBold Slant Right
	- Black Slant Right
	- ExtraBlack Slant Right
	- ExtraLight Slant Left
	- Light Slant Left
	- Slant Left
	- Medium Slant Left
	- SemiBold Slant Left
	- Bold Slant Left
	- ExtraBold Slant Left
	- Black Slant Left
	- ExtraBlack Slant Left

Further info can be found in our spec https://github.com/googlefonts/gf-docs/tree/main/Spec#fvar-instances [code: bad-instance-names]

</details>
<details>
<summary>🔥 <b>FAIL:</b> Ensure VFs do not contain slnt or ital axes. </summary>

* [com.google.fonts/check/varfont/unsupported_axes](https://font-bakery.readthedocs.io/en/latest/fontbakery/profiles/googlefonts.html#com.google.fonts/check/varfont/unsupported_axes)
<pre>--- Rationale ---
The &#x27;ital&#x27; and &#x27;slnt&#x27; axes are not supported yet in Google Chrome.
For the time being, we need to ensure that VFs do not contain either of these
axes. Once browser support is better, we can deprecate this check.
For more info regarding browser support, see:
https://arrowtype.github.io/vf-slnt-test/</pre>

* 🔥 **FAIL** The "slnt" axis is not yet well supported on Google Chrome. [code: unsupported-slnt]

</details>
<details>
<summary>🔥 <b>FAIL:</b> Validate STAT particle names and values match the fallback names in GFAxisRegistry. </summary>

* [com.google.fonts/check/STAT/gf-axisregistry](https://font-bakery.readthedocs.io/en/latest/fontbakery/profiles/googlefonts.html#com.google.fonts/check/STAT/gf-axisregistry)
<pre>--- Rationale ---
Check that particle names and values on STAT table match the fallback names in
each axis entry at the Google Fonts Axis Registry, available at
https://github.com/google/fonts/tree/main/axisregistry</pre>

* 🔥 **FAIL** On the font variation axis 'slnt', the name 'Left' is not among the expected ones (Default) according to the Google Fonts Axis Registry. [code: invalid-name]
* 🔥 **FAIL** On the font variation axis 'slnt', the name 'Normal' is not among the expected ones (Default) according to the Google Fonts Axis Registry. [code: invalid-name]
* 🔥 **FAIL** On the font variation axis 'slnt', the name 'Right' is not among the expected ones (Default) according to the Google Fonts Axis Registry. [code: invalid-name]
* 🔥 **FAIL** On the font variation axis 'wght', the name 'ExtraBlack' is not among the expected ones (Thin, ExtraLight, Light, Regular, Medium, SemiBold, Bold, ExtraBold, Black) according to the Google Fonts Axis Registry. [code: invalid-name]

</details>
<br>
</details>

### Summary

| 💔 ERROR | 🔥 FAIL | ⚠ WARN | 💤 SKIP | ℹ INFO | 🍞 PASS | 🔎 DEBUG |
|:-----:|:----:|:----:|:----:|:----:|:----:|:----:|
| 0 | 3 | 5 | 96 | 9 | 100 | 0 |
| 0% | 1% | 2% | 45% | 4% | 47% | 0% |

**Note:** The following loglevels were omitted in this report:
* **WARN**
* **SKIP**
* **INFO**
* **PASS**
* **DEBUG**
