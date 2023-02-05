;;; operator-mode.el --- simple electric operator  -*- lexical-binding: t; -*-

;; Copyright (C) 2018-2020  Andreas Röhler

;; Author: Andreas Röhler <andreas.roehler@online.de>
;; Keywords: convenience

;; Version: 0.0.1
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary: This is a still naive prototype


;;

;;; Code:

(defcustom operator-mode-in-comment-p nil
  "If operator-mode should expand inside comments.

Default is nil."
  )

(defcustom operator-mode-in-string-p t
  "If operator-mode should expand inside a string.

Default is t."
  )

(defvar operator-mode-debug t
  "Debugging mode")

(defvar operator-known-operators nil

  "Known chars used as operators.")

(setq operator-known-operators (list ?{ ?} ?\) ?/ ?` ?_ ?= ?: ?! ?$ ?% ?& ?* ?+ ?- ?. ?< ?> ?@ ?\, ?\; ?\? ?\⁅ ?\⁆ ?\⁽ ?\⁾ ?\₍ ?\₎ ?\〈 ?\⎴ ?\⎵ ?\⟦ ?\⟧ ?\⟨ ?\⟩ ?\⟪ ?\⟫ ?\⦃ ?\⦄ ?\《 ?\》 ?\「 ?\」 ?\『 ?\』 ?\〚 ?\〛 ?\︵ ?\︶ ?\︷ ?\︸ ?\︹ ?\︺ ?\︻ ?\︼ ?\︽ ?\︾ ?\︿ ?\﹀ ?\﹁ ?\﹂ ?\﹃ ?\﹄ ?\﹙ ?\﹚ ?\﹛ ?\﹜ ?\﹝ ?\﹞ ?\（ ?\） ?\［ ?\］ ?\｛ ?\｝ ?\｢ ?\｣ ?^ ?| ?~ ?¡ ?¢ ?£ ?¤ ?¥ ?¦ ?§ ?¨ ?© ?ª ?« ?¬ ?­ ?® ?¯ ?° ?± ?² ?³ ?´ ?µ ?¶ ?· ?¸ ?¹ ?º ?» ?¼ ?½ ?¾ ?¿ ?À ?Á ?Â ?Ã ?Å ?Æ ?Ç ?È ?É ?Ê ?Ë ?Ì ?Í ?Î ?Ï ?Ð ?Ñ ?Ò ?Ó ?Ô ?Õ ?× ?Ø ?Ù ?Ú ?Û ?Ü ?Ý ?Þ ?à ?á ?â ?ã ?å ?æ ?ç ?è ?é ?ê ?ë ?ì ?í ?î ?ï ?ð ?ñ ?ò ?ó ?ô ?õ ?÷ ?ø ?ù ?ú ?û ?ý ?þ ?ÿ ?Ā ?ā ?Ă ?ă ?Ą ?ą ?Ć ?ć ?Ĉ ?ĉ ?Ċ ?ċ ?Č ?č ?Ď ?ď ?Ē ?ē ?Ĕ ?ĕ ?Ė ?ė ?Ę ?ę ?Ě ?ě ?Ĝ ?ĝ ?Ğ ?ğ ?Ġ ?ġ ?Ģ ?ģ ?Ĥ ?ĥ ?Ĩ ?ĩ ?Ī ?ī ?Ĭ ?ĭ ?Į ?į ?İ ?ı ?Ĵ ?ĵ ?Ķ ?ķ ?Ĺ ?ĺ ?Ļ ?ļ ?Ľ ?ľ ?Ł ?ł ?Ń ?ń ?Ņ ?ņ ?Ň ?ň ?Ō ?ō ?Ŏ ?ŏ ?Ő ?ő ?Œ ?œ ?Ŕ ?ŕ ?Ŗ ?ŗ ?Ř ?ř ?Ś ?ś ?Ŝ ?ŝ ?Ş ?ş ?Š ?š ?Ţ ?ţ ?Ť ?ť ?Ũ ?ũ ?Ū ?ū ?Ŭ ?ŭ ?Ű ?ű ?Ų ?ų ?Ŵ ?ŵ ?Ŷ ?ŷ ?Ÿ ?Ź ?ź ?Ż ?ż ?Ž ?ž ?ƛ ?Ǎ ?ǎ ?Ǐ ?ǐ ?Ǒ ?ǒ ?Ǔ ?ǔ ?Ǖ ?ǖ ?Ǘ ?ǘ ?Ǚ ?ǚ ?Ǜ ?ǜ ?Ǟ ?ǟ ?Ǡ ?ǡ ?Ǣ ?ǣ ?Ǧ ?ǧ ?Ǩ ?ǩ ?Ǫ ?ǫ ?Ǭ ?ǭ ?ǰ ?Ǵ ?ǵ ?Ǹ ?ǹ ?Ǽ ?ǽ ?Ǿ ?ǿ ?Ȟ ?ȟ ?Ȧ ?ȧ ?Ȩ ?ȩ ?Ȫ ?ȫ ?Ȭ ?ȭ ?Ȯ ?ȯ ?Ȱ ?ȱ ?Ȳ ?ȳ ?ʰ ?ʱ ?ʲ ?ʳ ?ʴ ?ʵ ?ʶ ?ʷ ?ʸ ?ˇ ?˘ ?˙ ?˛ ?˜ ?˝ ?ˠ ?ˡ ?ˢ ?ˣ ?ˤ ?̀ ?́ ?̂ ?̃ ?̄ ?̅ ?̆ ?̇ ?̈ ?̋ ?̌ ?̑ ?̣ ?̤ ?̧ ?̨ ?̪ ?̬ ?̭ ?̮ ?̯ ?̰ ?̱ ?̲ ?̳ ?̸ ?̺ ?̿ ?͆ ?͌ ?͍ ?Ͱ ?ͱ ?Ϳ ?Α ?Β ?Γ ?Δ ?Ε ?Ζ ?Η ?Θ ?Ι ?Κ ?Λ ?Μ ?Ν ?Ξ ?Ο ?Π ?Ρ ?Σ ?Τ ?Υ ?Φ ?Χ ?Ψ ?Ω ?α ?β ?γ ?δ ?ε ?ζ ?η ?θ ?ι ?κ ?λ ?ν ?ξ ?ο ?π ?ρ ?ς ?σ ?τ ?υ ?φ ?χ ?ψ ?ω ?ϐ ?ϑ ?ϕ ?ϖ ?ϗ ?Ϛ ?ϛ ?Ϝ ?ϝ ?ϟ ?Ϡ ?ϡ ?Ϣ ?ϣ ?Ϥ ?ϥ ?Ϧ ?ϧ ?Ϩ ?ϩ ?Ϫ ?ϫ ?Ϭ ?ϭ ?Ϯ ?ϯ ?ϰ ?ϱ ?Ϸ ?ϸ ?Ϻ ?ϻ ?؋ ?฿ ?ᴬ ?ᴭ ?ᴮ ?ᴯ ?ᴰ ?ᴱ ?ᴲ ?ᴳ ?ᴴ ?ᴵ ?ᴶ ?ᴷ ?ᴸ ?ᴹ ?ᴺ ?ᴻ ?ᴼ ?ᴽ ?ᴾ ?ᴿ ?ᵀ ?ᵁ ?ᵂ ?ᵃ ?ᵄ ?ᵅ ?ᵆ ?ᵇ ?ᵈ ?ᵉ ?ᵊ ?ᵋ ?ᵌ ?ᵍ ?ᵎ ?ᵏ ?ᵐ ?ᵑ ?ᵒ ?ᵓ ?ᵔ ?ᵕ ?ᵖ ?ᵗ ?ᵘ ?ᵙ ?ᵚ ?ᵛ ?ᵜ ?ᵝ ?ᵞ ?ᵟ ?ᵠ ?ᵡ ?ᵢ ?ᵣ ?ᵤ ?ᵥ ?ᶛ ?ᶜ ?ᶝ ?ᶞ ?ᶟ ?ᶠ ?ᶡ ?ᶢ ?ᶣ ?ᶤ ?ᶥ ?ᶦ ?ᶧ ?ᶨ ?ᶩ ?ᶪ ?ᶫ ?ᶬ ?ᶭ ?ᶮ ?ᶯ ?ᶰ ?ᶱ ?ᶲ ?ᶳ ?ᶴ ?ᶵ ?ᶶ ?ᶷ ?ᶸ ?ᶹ ?ᶺ ?ᶻ ?ᶼ ?ᶽ ?ᶾ ?ᶿ ?Ḃ ?ḃ ?Ḅ ?ḅ ?Ḉ ?ḉ ?Ḋ ?ḋ ?Ḍ ?ḍ ?Ḑ ?ḑ ?Ḕ ?ḕ ?Ḗ ?ḗ ?Ḝ ?ḝ ?Ḟ ?ḟ ?Ḡ ?ḡ ?Ḣ ?ḣ ?Ḥ ?ḥ ?Ḧ ?ḧ ?Ḩ ?ḩ ?Ḯ ?ḯ ?Ḱ ?ḱ ?Ḳ ?ḳ ?Ḷ ?ḷ ?Ḹ ?ḹ ?Ḿ ?ḿ ?Ṁ ?ṁ ?Ṃ ?ṃ ?Ṅ ?ṅ ?Ṇ ?Ṍ ?ṍ ?Ṏ ?ṏ ?Ṑ ?ṑ ?Ṓ ?ṓ ?Ṕ ?ṕ ?Ṗ ?ṗ ?Ṙ ?ṙ ?Ṛ ?ṛ ?Ṝ ?ṝ ?Ṡ ?ṡ ?Ṣ ?ṣ ?Ṥ ?ṥ ?Ṧ ?ṧ ?Ṩ ?ṩ ?Ṫ ?ṫ ?Ṭ ?ṭ ?Ṹ ?ṹ ?Ṻ ?ṻ ?Ṽ ?ṽ ?Ṿ ?ṿ ?Ẁ ?ẁ ?Ẃ ?ẃ ?Ẅ ?ẅ ?Ẇ ?ẇ ?Ẉ ?ẉ ?Ẋ ?ẋ ?Ẍ ?ẍ ?Ẏ ?ẏ ?Ẑ ?ẑ ?Ẓ ?ẓ ?ẗ ?Ạ ?ạ ?Ấ ?ấ ?Ầ ?ầ ?Ẫ ?ẫ ?Ậ ?ậ ?Ắ ?ắ ?Ằ ?ằ ?Ẵ ?ẵ ?Ặ ?ặ ?Ẹ ?ẹ ?Ẽ ?ẽ ?Ế ?ế ?Ề ?ề ?Ễ ?ễ ?Ệ ?ệ ?Ị ?ị ?Ọ ?ọ ?Ố ?ố ?Ồ ?ồ ?Ỗ ?ỗ ?Ộ ?ộ ?Ụ ?ụ ?Ỳ ?ỳ ?Ỵ ?ỵ ?Ỹ ?ỹ ?  ?  ?– ?— ?‖ ?‘ ?’ ?‚ ?“ ?” ?„ ?† ?‡ ?• ?‣ ?… ?  ?‰ ?‱ ?′ ?‴ ?‵ ?‶ ?‷ ?‹ ?› ?※ ?‼ ?‽ ?‿ ?⁀ ?⁂ ?⁄ ?⁇ ?⁈ ?⁉ ?⁌ ?⁍ ?⁎ ?⁑ ?⁒ ?⁗ ?⁰ ?ⁱ ?⁴ ?⁵ ?⁶ ?⁷ ?⁸ ?⁹ ?⁺ ?⁻ ?⁼ ?ⁿ ?₀ ?₁ ?₂ ?₃ ?₄ ?₅ ?₆ ?₇ ?₈ ?₉ ?₊ ?₋ ?₌ ?ₐ ?ₑ ?ₒ ?ₓ ?ₕ ?ₖ ?ₗ ?ₘ ?ₙ ?ₚ ?ₛ ?ₜ ?₡ ?₢ ?₤ ?₥ ?₦ ?₧ ?₨ ?₩ ?₫ ?€ ?₭ ?₮ ?₯ ?₱ ?₲ ?₳ ?₴ ?₵ ?₷ ?₸ ?₼ ?₽ ?₾ ?⃐ ?⃑ ?⃔ ?⃕ ?⃖ ?⃗ ?⃛ ?⃜ ?⃝ ?⃡ ?ℂ ?℃ ?ℏ ?ℐ ?ℑ ?ℓ ?ℕ ?№ ?℗ ?℘ ?ℙ ?ℚ ?ℜ ?ℝ ?℞ ?℠ ?℡ ?™ ?ℤ ?℥ ?Ω ?℧ ?K ?Å ?℮ ?ℵ ?ℶ ?ℷ ?ℸ ?℻ ?⅀ ?⅋ ?⅌ ?⅓ ?⅔ ?⅕ ?⅖ ?⅗ ?⅘ ?⅙ ?⅚ ?⅛ ?⅜ ?⅝ ?⅞ ?⅟ ?← ?↑ ?→ ?↓ ?↔ ?↕ ?↖ ?↗ ?↘ ?↙ ?↚ ?↛ ?↜ ?↝ ?↞ ?↟ ?↠ ?↡ ?↢ ?↣ ?↤ ?↥ ?↦ ?↧ ?↨ ?↩ ?↪ ?↫ ?↬ ?↭ ?↮ ?↯ ?↰ ?↱ ?↲ ?↳ ?↴ ?↵ ?↶ ?↷ ?↸ ?↹ ?↺ ?↻ ?↼ ?↽ ?↾ ?↿ ?⇀ ?⇁ ?⇂ ?⇃ ?⇄ ?⇅ ?⇆ ?⇇ ?⇈ ?⇉ ?⇊ ?⇋ ?⇌ ?⇍ ?⇎ ?⇏ ?⇐ ?⇑ ?⇒ ?⇓ ?⇔ ?⇕ ?⇖ ?⇗ ?⇘ ?⇙ ?⇚ ?⇛ ?⇜ ?⇝ ?⇞ ?⇟ ?⇠ ?⇡ ?⇢ ?⇣ ?⇤ ?⇥ ?⇦ ?⇧ ?⇨ ?⇩ ?⇪ ?⇫ ?⇬ ?⇭ ?⇮ ?⇯ ?⇰ ?⇱ ?⇲ ?⇳ ?⇴ ?⇵ ?⇶ ?⇷ ?⇸ ?⇹ ?⇺ ?⇻ ?⇼ ?⇽ ?⇾ ?⇿ ?∀ ?∁ ?∂ ?∃ ?∄ ?∅ ?∆ ?∇ ?∈ ?∉ ?∊ ?∋ ?∌ ?∍ ?∎ ?∏ ?∐ ?∑ ?− ?∓ ?∔ ?∖ ?∗ ?∘ ?∙ ?√ ?∛ ?∜ ?∝ ?∞ ?∟ ?∠ ?∡ ?∢ ?∣ ?∤ ?∥ ?∦ ?∧ ?∨ ?∩ ?∪ ?∫ ?∬ ?∭ ?∮ ?∯ ?∰ ?∱ ?∲ ?∳ ?∴ ?∵ ?∶ ?∷ ?∸ ?∹ ?∺ ?∻ ?∼ ?∽ ?∾ ?∿ ?≀ ?≁ ?≂ ?≃ ?≄ ?≅ ?≆ ?≇ ?≈ ?≉ ?≊ ?≋ ?≌ ?≍ ?≎ ?≏ ?≐ ?≑ ?≒ ?≓ ?≔ ?≕ ?≖ ?≗ ?≘ ?≙ ?≚ ?≛ ?≜ ?≝ ?≞ ?≟ ?≠ ?≡ ?≢ ?≣ ?≤ ?≥ ?≦ ?≧ ?≨ ?≩ ?≪ ?≫ ?≬ ?≭ ?≮ ?≯ ?≰ ?≱ ?≲ ?≳ ?≴ ?≵ ?≶ ?≷ ?≸ ?≹ ?≺ ?≻ ?≼ ?≽ ?≾ ?≿ ?⊀ ?⊁ ?⊂ ?⊃ ?⊄ ?⊅ ?⊆ ?⊇ ?⊈ ?⊉ ?⊊ ?⊋ ?⊌ ?⊍ ?⊎ ?⊏ ?⊐ ?⊑ ?⊒ ?⊓ ?⊔ ?⊕ ?⊖ ?⊗ ?⊘ ?⊙ ?⊚ ?⊛ ?⊜ ?⊝ ?⊞ ?⊟ ?⊠ ?⊡ ?⊢ ?⊣ ?⊤ ?⊥ ?⊦ ?⊧ ?⊨ ?⊩ ?⊪ ?⊫ ?⊬ ?⊭ ?⊮ ?⊯ ?⊰ ?⊱ ?⊲ ?⊳ ?⊴ ?⊵ ?⊸ ?⊹ ?⊺ ?⊻ ?⊼ ?⊽ ?⊾ ?⊿ ?⋀ ?⋁ ?⋂ ?⋃ ?⋄ ?⋆ ?⋇ ?⋈ ?⋉ ?⋊ ?⋋ ?⋌ ?⋍ ?⋎ ?⋏ ?⋐ ?⋑ ?⋒ ?⋓ ?⋔ ?⋕ ?⋖ ?⋗ ?⋘ ?⋙ ?⋚ ?⋛ ?⋜ ?⋝ ?⋞ ?⋟ ?⋠ ?⋡ ?⋢ ?⋣ ?⋤ ?⋥ ?⋦ ?⋧ ?⋨ ?⋩ ?⋪ ?⋫ ?⋬ ?⋭ ?⋮ ?⋯ ?⋰ ?⋱ ?⋲ ?⋳ ?⋴ ?⋵ ?⋶ ?⋷ ?⋸ ?⋹ ?⋺ ?⋻ ?⋼ ?⋽ ?⋾ ?⋿ ?⌀ ?⌈ ?⌉ ?⌊ ?⌋ ?⌜ ?⌝ ?⌞ ?⌟ ?⌢ ?⌣ ?⌶ ?⌷ ?⌸ ?⌹ ?⌺ ?⌻ ?⌼ ?⌽ ?⌾ ?⌿ ?⍀ ?⍁ ?⍂ ?⍃ ?⍄ ?⍅ ?⍆ ?⍇ ?⍈ ?⍉ ?⍊ ?⍋ ?⍌ ?⍍ ?⍎ ?⍏ ?⍐ ?⍑ ?⍒ ?⍓ ?⍔ ?⍕ ?⍖ ?⍗ ?⍘ ?⍙ ?⍚ ?⍛ ?⍜ ?⍝ ?⍞ ?⍟ ?⍠ ?⍡ ?⍢ ?⍣ ?⍤ ?⍥ ?⍦ ?⍧ ?⍨ ?⍩ ?⍪ ?⍫ ?⍬ ?⍭ ?⍮ ?⍯ ?⍰ ?⍱ ?⍲ ?⍳ ?⍴ ?⍵ ?⍶ ?⍷ ?⍸ ?⍹ ?⍺ ?⎕ ?① ?② ?③ ?④ ?⑤ ?⑥ ?⑦ ?⑧ ?⑨ ?⑩ ?⑪ ?⑫ ?⑬ ?⑭ ?⑮ ?⑯ ?⑰ ?⑱ ?⑲ ?⑳ ?⑴ ?⑵ ?⑶ ?⑷ ?⑸ ?⑹ ?⑺ ?⑻ ?⑼ ?⑽ ?⑾ ?⑿ ?⒀ ?⒁ ?⒂ ?⒃ ?⒄ ?⒅ ?⒆ ?⒇ ?⒈ ?⒉ ?⒊ ?⒋ ?⒌ ?⒍ ?⒎ ?⒏ ?⒐ ?⒑ ?⒒ ?⒓ ?⒔ ?⒕ ?⒖ ?⒗ ?⒘ ?⒙ ?⒚ ?⒛ ?⒜ ?⒝ ?⒞ ?⒟ ?⒠ ?⒡ ?⒢ ?⒣ ?⒤ ?⒥ ?⒦ ?⒧ ?⒨ ?⒩ ?⒪ ?⒫ ?⒬ ?⒭ ?⒮ ?⒯ ?⒰ ?⒱ ?⒲ ?⒳ ?⒴ ?⒵ ?Ⓐ ?Ⓑ ?Ⓒ ?Ⓓ ?Ⓔ ?Ⓕ ?Ⓖ ?Ⓗ ?Ⓘ ?Ⓙ ?Ⓚ ?Ⓛ ?Ⓜ ?Ⓝ ?Ⓞ ?Ⓟ ?Ⓠ ?Ⓡ ?Ⓢ ?Ⓣ ?Ⓤ ?Ⓥ ?Ⓦ ?Ⓧ ?Ⓨ ?Ⓩ ?ⓐ ?ⓑ ?ⓒ ?ⓓ ?ⓔ ?ⓕ ?ⓖ ?ⓗ ?ⓘ ?ⓙ ?ⓚ ?ⓛ ?ⓜ ?ⓝ ?ⓞ ?ⓟ ?ⓠ ?ⓡ ?ⓢ ?ⓣ ?ⓤ ?ⓥ ?ⓦ ?ⓧ ?ⓨ ?ⓩ ?⓪ ?─ ?━ ?│ ?┃ ?┄ ?┅ ?┆ ?┇ ?┈ ?┉ ?┊ ?┋ ?┌ ?┍ ?┎ ?┏ ?┐ ?┑ ?┒ ?┓ ?└ ?┕ ?┖ ?┗ ?┘ ?┙ ?┚ ?┛ ?├ ?┝ ?┞ ?┟ ?┠ ?┡ ?┢ ?┣ ?┤ ?┥ ?┦ ?┧ ?┨ ?┩ ?┪ ?┫ ?┬ ?┭ ?┮ ?┯ ?┰ ?┱ ?┲ ?┳ ?┴ ?┵ ?┶ ?┷ ?┸ ?┹ ?┺ ?┻ ?┼ ?┽ ?┾ ?┿ ?╀ ?╁ ?╂ ?╃ ?╄ ?╅ ?╆ ?╇ ?╈ ?╉ ?╊ ?╋ ?╌ ?╍ ?╎ ?╏ ?═ ?║ ?╒ ?╓ ?╔ ?╕ ?╖ ?╗ ?╘ ?╙ ?╚ ?╛ ?╜ ?╝ ?╞ ?╟ ?╠ ?╡ ?╢ ?╣ ?╤ ?╥ ?╦ ?╧ ?╨ ?╩ ?╪ ?╫ ?╬ ?╭ ?╮ ?╯ ?╰ ?╱ ?╲ ?╳ ?╴ ?╵ ?╶ ?╷ ?╸ ?╹ ?╺ ?╻ ?╼ ?╽ ?╾ ?╿ ?■ ?□ ?▢ ?▣ ?▤ ?▥ ?▦ ?▧ ?▨ ?▩ ?▪ ?▬ ?▭ ?▮ ?▯ ?▰ ?▱ ?▲ ?△ ?▴ ?▵ ?▶ ?▷ ?▸ ?▹ ?► ?▻ ?▼ ?▽ ?▾ ?▿ ?◀ ?◁ ?◂ ?◃ ?◄ ?◅ ?◆ ?◇ ?◈ ?○ ?◌ ?◍ ?◎ ?● ?◐ ?◑ ?◒ ?◓ ?◔ ?◕ ?◖ ?◗ ?◠ ?◡ ?◢ ?◣ ?◤ ?◥ ?◦ ?◧ ?◨ ?◩ ?◪ ?◫ ?◬ ?◭ ?◮ ?◯ ?◰ ?◱ ?◲ ?◳ ?◴ ?◵ ?◶ ?◷ ?◸ ?◹ ?◺ ?◻ ?◼ ?◽ ?◾ ?◿ ?★ ?☆ ?☡ ?☢ ?☣ ?☹ ?☺ ?☻ ?♀ ?♂ ?♠ ?♢ ?♣ ?♥ ?♩ ?♪ ?♫ ?♬ ?♭ ?♮ ?♯ ?⚀ ?⚁ ?⚂ ?⚃ ?⚄ ?⚅ ?⚆ ?⚇ ?⚈ ?⚉ ?⚠ ?✂ ?✄ ?✉ ?✓ ?✝ ?✠ ?✢ ?✣ ?✤ ?✥ ?✦ ?✧ ?✪ ?✫ ?✯ ?✰ ?✱ ?✲ ?✳ ?✴ ?✵ ?✶ ?✷ ?✸ ?✹ ?✺ ?✻ ?✼ ?✽ ?❃ ?❉ ?❊ ?❋ ?❶ ?❷ ?❸ ?❹ ?❺ ?❻ ?❼ ?❽ ?❾ ?❿ ?➀ ?➁ ?➂ ?➃ ?➄ ?➅ ?➆ ?➇ ?➈ ?➉ ?➊ ?➋ ?➌ ?➍ ?➎ ?➏ ?➐ ?➑ ?➒ ?➓ ?➔ ?➘ ?➙ ?➚ ?➛ ?➜ ?➝ ?➞ ?➟ ?➠ ?➡ ?➢ ?➣ ?➤ ?➥ ?➦ ?➧ ?➨ ?➩ ?➪ ?➫ ?➬ ?➭ ?➮ ?➯ ?➱ ?➲ ?➳ ?➴ ?➵ ?➶ ?➷ ?➸ ?➹ ?➺ ?➻ ?➼ ?➽ ?➾ ?⟅ ?⟆ ?⟕ ?⟖ ?⟗ ?⟰ ?⟱ ?⟲ ?⟳ ?⟴ ?⟵ ?⟶ ?⟷ ?⟸ ?⟹ ?⟺ ?⟻ ?⟼ ?⟽ ?⟾ ?⟿ ?⤆ ?⤇ ?⨀ ?⨂ ?⨃ ?⨄ ?⨅ ?⨆ ?⨇ ?⨈ ?⨉ ?⨝ ?⨿ ?⯑ ?ⱼ ?ⱽ ?㉐ ?ꟸ ?ꟹ ?ꭜ ?ꭝ ?ꭞ ?ꭟ ?﷼ ?﹨ ?𐆎 ?𝐴 ?𝐵 ?𝐶 ?𝐷 ?𝐸 ?𝐹 ?𝐺 ?𝐻 ?𝐼 ?𝐽 ?𝐾 ?𝐿 ?𝑀 ?𝑁 ?𝑂 ?𝑃 ?𝑄 ?𝑅 ?𝑆 ?𝑇 ?𝑈 ?𝑉 ?𝑊 ?𝑋 ?𝑌 ?𝑍 ?𝑎 ?𝑏 ?𝑐 ?𝑑 ?𝑒 ?𝑓 ?𝑔 ?𝑖 ?𝑗 ?𝑘 ?𝑙 ?𝑚 ?𝑛 ?𝑜 ?𝑝 ?𝑞 ?𝑟 ?𝑠 ?𝑡 ?𝑢 ?𝑣 ?𝑤 ?𝑥 ?𝑦 ?𝑧 ?𝑨 ?𝑩 ?𝑪 ?𝑫 ?𝑬 ?𝑭 ?𝑮 ?𝑯 ?𝑰 ?𝑱 ?𝑲 ?𝑳 ?𝑴 ?𝑵 ?𝑶 ?𝑷 ?𝑸 ?𝑹 ?𝑺 ?𝑻 ?𝑼 ?𝑽 ?𝑾 ?𝑿 ?𝒀 ?𝒁 ?𝒂 ?𝒃 ?𝒄 ?𝒅 ?𝒆 ?𝒇 ?𝒈 ?𝒉 ?𝒊 ?𝒋 ?𝒌 ?𝒍 ?𝒎 ?𝒏 ?𝒐 ?𝒑 ?𝒒 ?𝒓 ?𝒔 ?𝒕 ?𝒖 ?𝒗 ?𝒘 ?𝒙 ?𝒚 ?𝒛 ?𝒜 ?𝒞 ?𝒟 ?𝒢 ?𝒥 ?𝒦 ?𝒩 ?𝒪 ?𝒫 ?𝒬 ?𝒮 ?𝒯 ?𝒰 ?𝒱 ?𝒲 ?𝒳 ?𝒴 ?𝒵 ?𝒶 ?𝒷 ?𝒸 ?𝒹 ?𝒻 ?𝒽 ?𝒾 ?𝒿 ?𝓀 ?𝓁 ?𝓂 ?𝓃 ?𝓅 ?𝓆 ?𝓇 ?𝓈 ?𝓉 ?𝓊 ?𝓋 ?𝓌 ?𝓍 ?𝓎 ?𝓏 ?𝓐 ?𝓑 ?𝓒 ?𝓓 ?𝓔 ?𝓕 ?𝓖 ?𝓗 ?𝓘 ?𝓙 ?𝓚 ?𝓛 ?𝓜 ?𝓝 ?𝓞 ?𝓟 ?𝓠 ?𝓡 ?𝓢 ?𝓣 ?𝓤 ?𝓥 ?𝓦 ?𝓧 ?𝓨 ?𝓩 ?𝓪 ?𝓫 ?𝓬 ?𝓭 ?𝓮 ?𝓯 ?𝓰 ?𝓱 ?𝓲 ?𝓳 ?𝓴 ?𝓵 ?𝓶 ?𝓷 ?𝓸 ?𝓹 ?𝓺 ?𝓻 ?𝓼 ?𝓽 ?𝓾 ?𝓿 ?𝔀 ?𝔁 ?𝔂 ?𝔃 ?𝔄 ?𝔅 ?𝔇 ?𝔈 ?𝔉 ?𝔊 ?𝔍 ?𝔎 ?𝔏 ?𝔐 ?𝔑 ?𝔒 ?𝔓 ?𝔔 ?𝔖 ?𝔗 ?𝔘 ?𝔙 ?𝔚 ?𝔛 ?𝔜 ?𝔞 ?𝔟 ?𝔠 ?𝔡 ?𝔢 ?𝔣 ?𝔤 ?𝔥 ?𝔦 ?𝔧 ?𝔨 ?𝔩 ?𝔪 ?𝔫 ?𝔬 ?𝔭 ?𝔮 ?𝔯 ?𝔰 ?𝔱 ?𝔲 ?𝔳 ?𝔴 ?𝔵 ?𝔶 ?𝔹 ?𝟘 ?𝟙 ?𝟚 ?𝟛 ?𝟜 ?𝟝 ?𝟞 ?𝟟 ?𝟠 ?𝟡 ?🚧 ?🛇 ?🛑))

;; cl-map might not be available

;; (defvar-local operator-known-operators-strg (cl-map 'string 'identity operator-known-operators)
;;   "Used to skip over operators at point.")

(defun operator-setup-strg (opes)
  (let (erg)
    (dolist (ele opes)
      (setq erg (concat (format "%s" (char-to-string ele)) erg)))
    erg))

(defvar-local operator-known-operators-strg (operator-setup-strg operator-known-operators)
  "Used to skip over operators at point.")

;; (setq operator-known-operators-strg (operator-setup-strg operator-known-operators))

(defun operator--return-complement-char-maybe (char)
  "Reverse reciproke CHARs as \"[\" to \"]\"."
  (pcase char
    (?+ ?-)
    (?- ?+)
    (92 47)
    (47 92)
    ;; (?' ?\")
    ;; (?\" ?')
    (?‘ ?’)
    (?` ?´)
    (?´ ?`)
    (?< ?>)
    (?> ?<)
    (?\( ?\))
    (?\) ?\()
    (?\] ?\[)
    (?\[ ?\])
    (?} ?{)
    (?{ ?})
    (?\〈 ?\〉)
    (?\⦑ ?\⦒)
    (?\⦓ ?\⦔)
    (?\【 ?\】)
    (?\⦗ ?\⦘)
    (?\⸤ ?\⸥)
    (?\「 ?\」)
    (?\《 ?\》)
    (?\⦕ ?\⦖)
    (?\⸨ ?\⸩)
    (?\⧚ ?\⧛)
    (?\｛ ?\｝)
    (?\（ ?\）)
    (?\［ ?\］)
    (?\｟ ?\｠)
    (?\｢ ?\｣)
    (?\❰ ?\❱)
    (?\❮ ?\❯)
    (?\“ ?\”)
    (?\❲ ?\❳)
    (?\⟨ ?\⟩)
    (?\⟪ ?\⟫)
    (?\⟮ ?\⟯)
    (?\⟦ ?\⟧)
    (?\⟬ ?\⟭)
    (?\❴ ?\❵)
    (?\❪ ?\❫)
    (?\❨ ?\❩)
    (?\❬ ?\❭)
    (?\᚛ ?\᚜)
    (?\〈 ?\〉)
    (?\⧼ ?\⧽)
    (?\⟅ ?\⟆)
    (?\⸦ ?\⸧)
    (?\﹛ ?\﹜)
    (?\﹙ ?\﹚)
    (?\﹝ ?\﹞)
    (?\⁅ ?\⁆)
    (?\⦏ ?\⦎)
    (?\⦍ ?\⦐)
    (?\⦋ ?\⦌)
    (?\₍ ?\₎)
    (?\⁽ ?\⁾)
    (?\༼ ?\༽)
    (?\༺ ?\༻)
    (?\⸢ ?\⸣)
    (?\〔 ?\〕)
    (?\『 ?\』)
    (?\⦃ ?\⦄)
    (?\〖 ?\〗)
    (?\⦅ ?\⦆)
    (?\〚 ?\〛)
    (?\〘 ?\〙)
    (?\⧘ ?\⧙)
    (?\⦉ ?\⦊)
    (?\⦇ ?\⦈)
    (?\〉 ?\〈)
    (?\⦒ ?\⦑)
    (?\⦔ ?\⦓)
    (?\】 ?\【)
    (?\⦘ ?\⦗)
    (?\⸥ ?\⸤)
    (?\」 ?\「)
    (?\》 ?\《)
    (?\⦖ ?\⦕)
    (?\⸩ ?\⸨)
    (?\⧛ ?\⧚)
    (?\｝ ?\｛)
    (?\） ?\（)
    (?\］ ?\［)
    (?\｠ ?\｟)
    (?\｣ ?\｢)
    (?\❱ ?\❰)
    (?\❯ ?\❮)
    (?\” ?\“)
    (?\’ ?\‘)
    (?\❳ ?\❲)
    (?\⟩ ?\⟨)
    (?\⟫ ?\⟪)
    (?\⟯ ?\⟮)
    (?\⟧ ?\⟦)
    (?\⟭ ?\⟬)
    (?\❵ ?\❴)
    (?\❫ ?\❪)
    (?\❩ ?\❨)
    (?\❭ ?\❬)
    (?\᚜ ?\᚛)
    (?\〉 ?\〈)
    (?\⧽ ?\⧼)
    (?\⟆ ?\⟅)
    (?\⸧ ?\⸦)
    (?\﹜ ?\﹛)
    (?\﹚ ?\﹙)
    (?\﹞ ?\﹝)
    (?\⁆ ?\⁅)
    (?\⦎ ?\⦏)
    (?\⦐ ?\⦍)
    (?\⦌ ?\⦋)
    (?\₎ ?\₍)
    (?\⁾ ?\⁽)
    (?\༽ ?\༼)
    (?\༻ ?\༺)
    (?\⸣ ?\⸢)
    (?\〕 ?\〔)
    (?\』 ?\『)
    (?\⦄ ?\⦃)
    (?\〗 ?\〖)
    (?\⦆ ?\⦅)
    (?\〛 ?\〚)
    (?\〙 ?\〘)
    (?\⧙ ?\⧘)
    (?\⦊ ?\⦉)
    (?\⦈ ?\⦇)
    (_ char)))

(defun following--operator-up ()
  (save-excursion
    (and (< 0 (abs (skip-chars-backward operator-known-operators-strg)))
	 (member (char-before) operator-known-operators)
	 (char-before))))

(defun op-in-string-or-comment-p (&optional pps)
  "Returns beginning position if inside a string or comment,
t at start,nil otherwise.

Optional arg PPS output of (parse-partial-sexp (point-min) (point))"
  (interactive)
  (let* ((erg (or (and pps (nth 8 pps))
		  (nth 8 (parse-partial-sexp (point-min) (point)))
		  (ignore-errors (eq 7 (car-safe (syntax-after (point)))))
		  ;; (ignore-errors (eq 7 (car-safe (syntax-after (1- (point))))))
		  (and comment-start
		       (or (looking-at comment-start)
			   (looking-back comment-start (line-beginning-position))))
		  (and comment-start-skip
		       (or (looking-at comment-start-skip)
			   (looking-back comment-start-skip (line-beginning-position)))))))
    (when (interactive-p) (message "%s" erg))
    erg))

(defun py-in-dict-p (pps)
  "Return t if inside a dictionary."
  (save-excursion
    (and (nth 1 pps)
	 (goto-char (nth 1 pps))
	 (char-equal ?{ (char-after)))))

(defun operator--continue-p ()
  "Uses-cases:
"
  (when (member (char-before (- (point) 1)) operator-known-operators)
    'operator-continue))

(defun operator--in-list-continue-p (list_start_c following_start_c)
  "Use-cases:
Haskell: (>=>) :: Monad"
  (and list_start_c following_start_c (char-equal list_start_c ?\()
       (member following_start_c operator-known-operators)))

(defun operator--closing-colon (char)
  (and (char-equal char ?:)
       ;; (char-equal (char-before (- (point) 1)) ?\))
       (not (char-equal (char-before (- (point) 1)) 32))))

(defun operator--clojure-notfirst (char pps list-start-char notfirst)
  (cond (notfirst
	 'clojure-notfirst)
	((member (save-excursion (backward-char) (string= "Data" (word-at-point))) clojure-font-lock-keywords)
	 'clojure-font-lock-keyword)
	((and (eq char ?.)(looking-back "[ \t]+[0-9]\." (line-beginning-position)))
	 'float)
	((and (eq 'clojure-interactive-mode major-mode)
	      (save-excursion (backward-char 1)
			      (looking-back
			       (concat clojure-interactive-prompt "*")
			       ;; clojure-interactive-prompt
			       (line-beginning-position))))
	 'clojure-clojure-interactive-prompt)
	(list-start-char
	 ;; data Contact =  Contact { name :: "asdf" }
	 ;; (unless (eq list-start-char ?{)
	 (cond ((char-equal ?, char)
		'clojure-list-separator)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?. char))
		'clojure-construct-for-export)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?, char))
		'clojure-operator--in-list-continue)
	       ((char-equal ?* char)
		'clojure-char-equal-\*-in-list-p)
	       ((member char (list ?\( ?\) ?\]))
		'clojure-listing)
	       ((nth 3 pps)
		'clojure-and-nth-1-pps-nth-3-pps)
	       ;; ((and (nth 1 pps) (not (member char (list ?, ?\[ ?\] ?\)))))
	       ;; 	'clojure-in-list-p)
	       ((and
		 (nth 1 pps)(not (member char (list ?, ?\[ ?\] ?\)))))
		'clojure-in-list-p)
	       ((and (char-equal ?: char) (looking-back "(.:" (line-beginning-position)))
		'pattern-match-on-list)
	       ))
	;; ((member char (list ?\; ?,)))
	((or (member (char-before (1- (point))) operator-known-operators)
	     (and (eq (char-before (1- (point)))?\s) (member (char-before (- (point) 2)) operator-known-operators)))
	 'clojure-join-known-operators)
	((looking-back "<\\*" (line-beginning-position))
	 'clojure-<)
	((looking-back "^-" (line-beginning-position))
	 'clojure-comment-start)
	((looking-back "lambda +\\_<[^ ]+\\_>:" (line-beginning-position)))
	((looking-back "return +[^ ]+" (line-beginning-position)))
	((looking-back "import +[^ ]+" (line-beginning-position))
	 'clojure-import)
	((looking-back "forall +[^ ]+.*" (line-beginning-position)))))

(defun operator--clojure-notsecond (char pps list-start-char notsecond)
  (cond (notsecond
	 'clojure-notsecond)
	((and (eq char ?.)(looking-back "[ \t]+[0-9]\." (line-beginning-position)))
	 'float)
	((member char (list ?\[  ?\( ?{ ?\] ?\) ?}))
	 'clojure-list-delimter)
	((and (eq 'clojure-interactive-mode major-mode)
	      (save-excursion (backward-char)
			      (looking-back
			       (concat clojure-interactive-prompt "*")
			       ;; clojure-interactive-prompt
			       (line-beginning-position))))
	 'clojure-clojure-interactive-prompt)
	((nth 3 pps)
	 'clojure-in-string)
	;; index-p
	((and
	  ;; "even <$> (2,2)"
	  (not (char-equal char ?,))
	  (looking-back "^return +[^ ]+.*" (line-beginning-position))))
	((looking-back "^-" (line-beginning-position))
	 'clojure-comment-start)
	((looking-back "import +[^ ]+." (line-beginning-position))
	 'clojure-import)
	((looking-back "<\\*" (line-beginning-position))
	 'clojure->)
	((and
		 (nth 1 pps)
		 (not (member char (list ?, ?\[ ?\] ?\))))
		 ;; ->
		 (not (looking-back "-." (line-beginning-position))))
		'clojure-in-list-p)
	;; ((and (nth 1 pps)
	;;       (or (eq (1- (current-column)) (current-indentation))
	;; 	  (not (string-match "[[:blank:]]" (buffer-substring-no-properties (nth 1 pps) (point))))))
	;;  (save-excursion (goto-char (nth 1 pps))
	;; 		 (setq clojure-in-list-p (operator--return-complement-char-maybe (char-after)))))
	(list-start-char
	 ;; data Contact =  Contact { name :: "asdf" }
	 (cond ;; (
	       ;; 	(char-equal ?, char)
	       ;; 	'clojure-list-separator)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?, char))
		'clojure-construct-for-export)
	       ((and (char-equal ?: char) (looking-back "(.:" (line-beginning-position)))
		'pattern-match-on-list)))))

(defun operator--do-clojure-mode (char orig pps list-start-char &optional notfirst notsecond)
  "Haskell"
  (let* ((notfirst (operator--clojure-notfirst char pps list-start-char notfirst))
	 (notsecond (operator--clojure-notsecond char pps list-start-char notsecond))
	 (nojoin
	  (cond ((member char (list ?_ ?, ?\[ ?\] ?\))))
		((and (member char (list ?= ))
		     (save-excursion (backward-char)
				     (looking-back "_ +" (line-beginning-position)))))
		((save-excursion (backward-char)
				 (looking-back ") +" (line-beginning-position)))))))
    (operator--final char orig notfirst notsecond nojoin)))

(defun operator--python-notfirst (char start pps list-start-char &optional notfirst notsecond nojoin)
  (let* ((in-list-p (nth 1 pps))
	 (index-p (when in-list-p (save-excursion (goto-char (nth 1 pps)) (and (eq (char-after) ?\[) (not (eq (char-before) 32)))))))
    (cond (notfirst
	   notfirst)
	  ;; echo(**kargs)
	  ((and (member char (list ?* ?=)) in-list-p)
	   'python-*-in-list-p)
	  ;; print('%(language)s has %(number)03d quote types.' %
	  ;;     {'language': "Python", "number": 2})
	  ;; don'python-t space ‘%’
	  ;; print(f"Elementweise Addition: {m1 + m2}
	  ;; ((and (nth 1 pps) (nth 3 pps)
	  ;; 	'python-string-in-list))
	  ;; with open('/path/to/some/file') as file_1,
	  ((member char (list ?\; ?, 40 41 ?@))
	   'python-list-op)
	  ((member char (list ?- ?. ?_))
	   'python-dot)
	  ;; def f(x, y):
	  ;; if len(sys.argv) == 1:
	  ((operator--closing-colon char)
	   'python-operator--closing-colon)
	  (index-p
	   'python-index-p)
	  ((py-in-dict-p pps)
	   'python-py-in-dict-p)
	  ((or (looking-back "lambda +\\_<[^ ]+\\_>:" (line-beginning-position))
	       ;; for i in c :
	       (looking-back "\\_<for\\_>+ +\\_<[^ ]+\\_> +in +\\_<[^ ]+:" (line-beginning-position))
	       (looking-back "\\_<as\\_>+ +\\_<[^ ]+:" (line-beginning-position))
	       (looking-back "return +[^ ]+" (line-beginning-position)))
	   'python-after-symbol))))

(defun operator--python-notsecond (char start pps list-start-char &optional notfirst notsecond nojoin)
  (let* ((in-list-p (nth 1 pps))
	 (index-p (when in-list-p (save-excursion (goto-char (nth 1 pps)) (and (eq (char-after) ?\[) (not (eq (char-before) 32)))))))
    (cond (notsecond
	   notsecond)
	  ;; echo(**kargs)
	  ((and (member char (list ?* ?=)) in-list-p)
	   'python-*-in-list-p)
	  ((and (char-equal ?- char) in-list-p)
	   'python---in-list-p)
	  ;; print('%(language)s has %(number)03d quote types.' %
	  ;;     {'language': "Python", "number": 2})
	  ;; don't space ‘%’
	  ;; print(f"Elementweise Addition: {m1 + m2}
	  ;; ((and (nth 1 pps) (nth 3 pps))
	  ;;  'python-string-in-list)
	  ;; (char-equal char ?~)
	  ;; with open('/path/to/some/file') as file_1,
	  ((member char (list ?\; ?\( ?\) ?~ ?\[ ?\] ?@))
	   'python-list-op)
	  ((member char (list ?- ?. ?_))
	   'python-dot)
	  ((member char (list ?:))
	   'python-colon)
	  ((or (looking-back "[ \t]*\\_<\\(async def\\|class\\|def\\)\\_>[ \n\t]+\\([[:alnum:]_]+ *(.*)-\\)" (line-beginning-position))
	       (and
		;; return self.first_name, self.last_name
		(not (char-equal char ?,))
		(looking-back "return +[^ ]+.*" (line-beginning-position))))
	   'python-after-symbol))))

(defun operator--do-python-mode (char start pps list-start-char &optional notfirst notsecond nojoin)
  "Python"
  (setq operator-known-operators (remove ?. operator-known-operators))
  (let* ((notfirst (operator--python-notfirst char start pps list-start-char notfirst notsecond nojoin))
	 (notsecond (operator--python-notsecond char start pps list-start-char notfirst notsecond nojoin)))
    (operator--final char start notfirst notsecond nojoin)))


(defun operator--java-notfirst (char start pps list-start-char &optional notfirst notsecond nojoin)
  (let* ((in-list-p (and (nth 1 pps) (save-excursion (goto-char (nth 1 pps)) (not (eq (char-after) ?{)))))
	 (index-p (when in-list-p (save-excursion (goto-char (nth 1 pps)) (and (eq (char-after) ?\[) (not (eq (char-before) 32)))))))
    (cond (notfirst
	   notfirst)
	  ;; echo(**kargs)
	  ((and (member char (list ?* ?=)) in-list-p)
	   'java-*-in-list-p)
	  ;; print('%(language)s has %(number)03d quote types.' %
	  ;;     {'language': "Python", "number": 2})
	  ;; don'java-t space ‘%’
	  ;; ((and (nth 1 pps) (nth 3 pps)
	  ;; 	'java-string-in-list))
	  ;; with open('/path/to/some/file') as file_1,
	  ((member char (list ?\; ?, 40 41 ?@))
	   'java-list-op)
	  ((member char (list ?.))
	   'java-dot)
	  ;; def f(x, y):
	  ;; if len(sys.argv) == 1:
	  ((operator--closing-colon char)
	   'java-operator--closing-colon)
	  (index-p
	   'java-index-p)
	  ((or (looking-back "lambda +\\_<[^ ]+\\_>:" (line-beginning-position))
	       ;; for i in c :
	       (looking-back "\\_<for\\_>+ +\\_<[^ ]+\\_> +in +\\_<[^ ]+:" (line-beginning-position))
	       (looking-back "\\_<as\\_>+ +\\_<[^ ]+:" (line-beginning-position))
	       (looking-back "return +[^ ]+" (line-beginning-position)))
	   'java-after-symbol))))

(defun operator--java-notsecond (char start pps list-start-char &optional notfirst notsecond nojoin)
  (let* ((in-list-p (and (nth 1 pps) (save-excursion (goto-char (nth 1 pps)) (not (eq (char-after) ?{)))))
	 (index-p (when in-list-p (save-excursion (goto-char (nth 1 pps)) (and (eq (char-after) ?\[) (not (eq (char-before) 32)))))))
    (cond (notsecond
	   notsecond)
	  ;; echo(**kargs)
	  ((and (member char (list ?* ?=)) in-list-p)
	   'java-*-in-list-p)
	  ((and (char-equal ?- char) in-list-p)
	   'java---in-list-p)
	  ;; print('%(language)s has %(number)03d quote types.' %
	  ;;     {'language': "Python", "number": 2})
	  ;; don't space ‘%’
	  ((and (nth 1 pps) (nth 3 pps))
	   'java-string-in-list)
	  ;; (char-equal char ?~)
	  ;; with open('/path/to/some/file') as file_1,
	  ((member char (list ?\; ?\( ?\) ?~ ?\[ ?\] ?@))
	   'java-list-op)
	  ((member char (list ?.))
	   'java-dot)
	  ((member char (list ?:))
	   'java-colon)
	  ((or (looking-back "[ \t]*\\_<\\(async def\\|class\\|def\\)\\_>[ \n\t]+\\([[:alnum:]_]+ *(.*)-\\)" (line-beginning-position))
	       (and
		;; return self.first_name, self.last_name
		(not (char-equal char ?,))
		(looking-back "return +[^ ]+.*" (line-beginning-position))))
	   'java-after-symbol))))

(defun operator--do-java-mode (char start pps list-start-char &optional notfirst notsecond nojoin)
  "Python"
  (setq operator-known-operators (remove ?. operator-known-operators))
  (let* ((notfirst (operator--java-notfirst char start pps list-start-char notfirst notsecond nojoin))
	 (notsecond (operator--java-notsecond char start pps list-start-char notfirst notsecond nojoin)))
    (operator--final char start notfirst notsecond nojoin)))

(defun operator--sql-notfirst (char start pps list-start-char &optional notfirst notsecond nojoin)
  (let* ((in-list-p (nth 1 pps))
	 (index-p (when in-list-p (save-excursion (goto-char (nth 1 pps)) (and (eq (char-after) ?\[) (not (eq (char-before) 32)))))))
    (cond (notfirst
	   notfirst)
	  (in-list-p
	   'sql-*-in-list-p)
	  ((and (nth 1 pps) (nth 3 pps)
		'sql-string-in-list))
	  ((member char (list ?\; ?, 40 41 ?@))
	   'sql-list-op)
	  ((member char (list ?.))
	   'sql-dot)
	  ((operator--closing-colon char)
	   'sql-operator--closing-colon)
	  (index-p
	   'sql-index-p)
	  ((or
	    (looking-back "\\_<as\\_>+ +\\_<[^ ]+:" (line-beginning-position)))
	   'sql-after-symbol))))

(defun operator--sql-notsecond (char start pps list-start-char &optional notfirst notsecond nojoin)
  (let* ((in-list-p (nth 1 pps))
	 (index-p (when in-list-p (save-excursion (goto-char (nth 1 pps)) (and (eq (char-after) ?\[) (not (eq (char-before) 32)))))))
    (cond (notsecond
	   notsecond)
	  ((and (member char (list ?* ?=)) in-list-p)
	   'sql-*-in-list-p)
	  (in-list-p
	   'sql-in-list-p)
	  ((and (nth 1 pps) (nth 3 pps))
	   'sql-string-in-list)
	  ((member char (list ?\; ?\( ?\) ?~ ?\[ ?\] ?@))
	   'sql-list-op)
	  ((member char (list ?.))
	   'sql-dot)
	  ((member char (list ?:))
	   'sql-colon))))

(defun operator--do-sql-mode (char start pps list-start-char &optional notfirst notsecond nojoin)
  "Sql"
  (setq operator-known-operators (remove ?. operator-known-operators))
  (let* ((notfirst (operator--sql-notfirst char start pps list-start-char notfirst notsecond nojoin))
	 (notsecond (operator--sql-notsecond char start pps list-start-char notfirst notsecond nojoin)))
    (operator--final char start notfirst notsecond nojoin)))

(defun operator--haskell-notfirst (char pps list-start-char notfirst)
  (cond (notfirst
	 'haskell-notfirst)
	((member (save-excursion (backward-char) (string= "Data" (word-at-point))) haskell-font-lock-keywords)
	 'haskell-font-lock-keyword)
	((and (eq char ?.)(looking-back "[ \t]+[0-9]\." (line-beginning-position)))
	 'float)
	((and (eq 'haskell-interactive-mode major-mode)
	      (save-excursion (backward-char 1)
			      (looking-back
			       (concat haskell-interactive-prompt "*")
			       ;; haskell-interactive-prompt
			       (line-beginning-position))))
	 'haskell-haskell-interactive-prompt)
	((member char (list ?\; ?,))
	 'separator)
	((looking-back "<\\*" (line-beginning-position))
	 'haskell-<)
	((looking-back "^-" (line-beginning-position))
	 'haskell-comment-start)
	((looking-back "lambda +\\_<[^ ]+\\_>:" (line-beginning-position)))
	((looking-back "return +[^ ]+" (line-beginning-position)))
	((looking-back "import +[^ ]+" (line-beginning-position))
	 'haskell-import)
	((looking-back "forall +[^ ]+.*" (line-beginning-position)))
	(list-start-char
	 ;; data Contact =  Contact { name :: "asdf" }
	 ;; (unless (eq list-start-char ?{)
	 (cond ((char-equal ?, char)
		'haskell-list-separator)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?. char))
		'haskell-construct-for-export)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?, char))
		'haskell-operator--in-list-continue)
	       ;; let x = 5 in x * x
	       ;; ((char-equal ?* char)
	       ;; 	'haskell-char-equal-\*-in-list-p)
	       ((member char (list ?\( ?\) ?\] ?_))
		'haskell-listing)
	       ((and (nth 1 pps)
                     ;; (member char (list ?$))
                     (eq (nth 1 pps) (- (point) 2)))
		;; "pure ($ y) <*> u"
		'in-list)
	       ((and (nth 3 pps)(not (eq (char-before) ?|)))
		'haskell-and-nth-1-pps-nth-3-pps)
	       ((and (char-equal ?: char) (looking-back "(.:" (line-beginning-position)))
		'pattern-match-on-list)
	       ))))

(defun operator--haskell-notsecond (char pps list-start-char notsecond)
  (cond (notsecond
	 'haskell-notsecond)
	((and (eq char ?.) (looking-back "[ \t]+[0-9]\." (line-beginning-position)))
	 'float)
	((member char (list ?\[  ?\( ?{ ?\] ?\) ?}))
	 'haskell-list-delimter)
	((and (eq 'haskell-interactive-mode major-mode)
	      (save-excursion (backward-char)
			      (looking-back
			       (concat haskell-interactive-prompt "*")
			       ;; haskell-interactive-prompt
			       (line-beginning-position))))
	 'haskell-haskell-interactive-prompt)
	((and (nth 3 pps)(not (eq (char-before) ?|)))
	 'haskell-in-string)
	;; index-p
	((and
	  ;; "even <$> (2,2)"
	  (not (char-equal char ?,))
	  (looking-back "^return +[^ ]+.*" (line-beginning-position))))
	((looking-back "^-" (line-beginning-position))
	 'haskell-comment-start)
	((looking-back "import +[^ ]+." (line-beginning-position))
	 'haskell-import)
	((looking-back "<\\*" (line-beginning-position))
	 'haskell->)
        ;; ((and (nth 1 pps) (not (and (eq (char-before (1- (point))) 40) (eq char ?$))))
        ;;  ;; (and (nth 1 pps) (eq (nth 1 pps) (- (point) 2)))
        ;;  'in-list)
	((and
	  (nth 1 pps)
          (or
           (and
            (not (string-match "[[:alnum:] ]+" (buffer-substring-no-properties (nth 1 pps) (point))))
            ;; "pure ($ y) <*> u"
            (not (and (eq (char-before (1- (point))) 40) (eq char ?$)))
            ;; (<=
            ;; (==)
            ;; mylast (_:xs) = mylast xs
            ;; (<$>)
            ;; pure (.
            (member char (list ?< ?> ?= ?_ ?- ?$ ?.)))
           (and (string-match "[[:alnum:] ]+" (buffer-substring-no-properties (nth 1 pps) (point)))
                ;; "(september <|> oktober)"
                (member char (list ?< ?|))
                list-start-char (char-equal 40 list-start-char))))
	 ;; (not (looking-back "-." (line-beginning-position)))
	 'haskell-in-list-p)
        ;; ((looking-back " *}*;" (line-beginning-position))
        ;;  'semicolon-braced-list-start-char)
        ;; ;; data Contact =  Contact { name :: "asdf" }
        ;; (cond ;; (
        ;;  ;; 	(char-equal ?, char)
        ;;  ;; 	'haskell-list-separator)
        ((and list-start-char (char-equal ?\[ list-start-char)
              ;; evens n = map f [1..n]
              (member char (list ?, ?.))
	      ;; (char-equal ?, char)
              )
         'haskell-in-bracketed)
        ((and (char-equal ?: char) (looking-back "(.:" (line-beginning-position)))
         'pattern-match-on-list)))

(defun operator--do-haskell-mode (char orig pps list-start-char &optional notfirst notsecond)
  "Haskell"
  (let* ((notfirst (operator--haskell-notfirst char pps list-start-char notfirst))
	 (notsecond (operator--haskell-notsecond char pps list-start-char notsecond))
	 (nojoin
	  (cond ((member char (list ?_ ?, ?\[ ?\] ?\))))
		((and (member char (list ?=))
		      (save-excursion (backward-char)
				      (looking-back "_ +" (line-beginning-position)))))
		((save-excursion (backward-char)
				 (looking-back ") +" (line-beginning-position)))))))
    (operator--final char orig notfirst notsecond nojoin)))

(defun operator--haskell-interactive-notfirst (char pps list-start-char notfirst)
  (cond (notfirst
	 'haskell-notfirst)
	((member (save-excursion (backward-char) (string= "Data" (word-at-point))) haskell-font-lock-keywords)
	 'haskell-font-lock-keyword)
	((and (eq char ?.)(looking-back "[ \t]+[0-9]\." (line-beginning-position)))
	 'float)
        ;; λ> :l foo.hs
        ((and (eq char ?.)(looking-back ":[[:alpha:]][^:]*" (line-beginning-position)))
	 'loading)
	((and (eq 'haskell-interactive-mode major-mode)
	      (save-excursion (backward-char 1)
			      (looking-back
			       (concat haskell-interactive-prompt "*")
			       ;; haskell-interactive-prompt
			       (line-beginning-position))))
	 'haskell-haskell-interactive-prompt)
	((member char (list ?\; ?, ?/))
	 'separator)
	((looking-back "<\\*" (line-beginning-position))
	 'haskell-<)
	((looking-back "^-" (line-beginning-position))
	 'haskell-comment-start)
	((looking-back "lambda +\\_<[^ ]+\\_>:" (line-beginning-position)))
	((looking-back "return +[^ ]+" (line-beginning-position)))
	((looking-back "import +[^ ]+" (line-beginning-position))
	 'haskell-import)
	((looking-back "forall +[^ ]+.*" (line-beginning-position)))
	(list-start-char
	 ;; data Contact =  Contact { name :: "asdf" }
	 ;; (unless (eq list-start-char ?{)
	 (cond ((char-equal ?, char)
		'haskell-list-separator)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?. char))
		'haskell-construct-for-export)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?, char))
		'haskell-operator--in-list-continue)
	       ;; let x = 5 in x * x
	       ;; ((char-equal ?* char)
	       ;; 	'haskell-char-equal-\*-in-list-p)
	       ((member char (list ?\( ?\) ?\] ?_))
		'haskell-listing)
	       ((and (nth 1 pps)
                     ;; (member char (list ?$))
                     (eq (nth 1 pps) (- (point) 2)))
		;; "pure ($ y) <*> u"
		'in-list)
	       ((and (nth 3 pps)(not (eq (char-before) ?|)))
		'haskell-and-nth-1-pps-nth-3-pps)
	       ((and (char-equal ?: char) (looking-back "(.:" (line-beginning-position)))
		'pattern-match-on-list)
	       ))))

(defun operator--haskell-interactive-notsecond (char pps list-start-char notsecond)
  (cond (notsecond
	 'haskell-notsecond)
	((and (eq char ?.) (looking-back "[ \t]+[0-9]\." (line-beginning-position)))
	 'float)
        ;; λ> :l foo.hs
        ((and (eq char ?.)(looking-back ":[[:alpha:]][^:]*" (line-beginning-position)))
	 'loading)
	((member char (list ?\[  ?\( ?{ ?\] ?\) ?}))
	 'haskell-list-delimter)
	((and (eq 'haskell-interactive-mode major-mode)
	      (save-excursion (backward-char)
			      (looking-back
			       (concat haskell-interactive-prompt "*")
			       ;; haskell-interactive-prompt
			       (line-beginning-position))))
	 'haskell-haskell-interactive-prompt)
	((and (nth 3 pps)(not (eq (char-before) ?|)))
	 'haskell-in-string)
	;; index-p
	((and
	  ;; "even <$> (2,2)"
	  (not (char-equal char ?,))
	  (looking-back "^return +[^ ]+.*" (line-beginning-position))))
	((looking-back "^-" (line-beginning-position))
	 'haskell-comment-start)
	((looking-back "import +[^ ]+." (line-beginning-position))
	 'haskell-import)
	((looking-back "<\\*" (line-beginning-position))
	 'haskell->)
        ;; ((and (nth 1 pps) (not (and (eq (char-before (1- (point))) 40) (eq char ?$))))
        ;;  ;; (and (nth 1 pps) (eq (nth 1 pps) (- (point) 2)))
        ;;  'in-list)
	((and
	  (nth 1 pps)
          (or
           (and
            (not (string-match "[[:alnum:] ]+" (buffer-substring-no-properties (nth 1 pps) (point))))
            ;; "pure ($ y) <*> u"
            (not (and (eq (char-before (1- (point))) 40) (eq char ?$)))
            ;; (<=
            ;; (==)
            ;; mylast (_:xs) = mylast xs
            ;; (<$>)
            ;; pure (.
            (member char (list ?< ?> ?= ?_ ?- ?$ ?.)))
           (and (string-match "[[:alnum:] ]+" (buffer-substring-no-properties (nth 1 pps) (point)))
                ;; "(september <|> oktober)"
                (member char (list ?< ?|))
                list-start-char (char-equal 40 list-start-char))))
	 ;; (not (looking-back "-." (line-beginning-position)))
	 'haskell-in-list-p)
        ;; ((looking-back " *}*;" (line-beginning-position))
        ;;  'semicolon-braced-list-start-char)
        ;; ;; data Contact =  Contact { name :: "asdf" }
        ;; (cond ;; (
        ((member char (list ?/))
	 'separator)
        ((and list-start-char (char-equal ?\[ list-start-char)
              ;; evens n = map f [1..n]
              (member char (list ?, ?.))
	      ;; (char-equal ?, char)
              )
         'haskell-in-bracketed)
        ((and (char-equal ?: char) (looking-back "(.:" (line-beginning-position)))
         'pattern-match-on-list)))

(defun operator--do-haskell-interactive-mode (char orig pps list-start-char &optional notfirst notsecond)
  "Haskell"
  (let* ((notfirst (operator--haskell-interactive-notfirst char pps list-start-char notfirst))
	 (notsecond (operator--haskell-interactive-notsecond char pps list-start-char notsecond))
	 (nojoin
	  (cond ((member char (list ?_ ?, ?\[ ?\] ?\))))
		((and (member char (list ?=))
		      (save-excursion (backward-char)
				      (looking-back "_ +" (line-beginning-position)))))
		((save-excursion (backward-char)
				 (looking-back ") +" (line-beginning-position)))))))
    (operator--final char orig notfirst notsecond nojoin)))

(defun operator--idris-notfirst (char pps list-start-char notfirst)
  (cond (notfirst
	 'idris-notfirst)
	((and (eq char ?.)(looking-back "[ \t]+[0-9]\." (line-beginning-position)))
	 'float)
	((and (eq 'idris-interactive-mode major-mode)
	      (save-excursion (backward-char 1)
			      (looking-back idris-interactive-prompt (line-beginning-position))))
	 'idris-idris-interactive-prompt)
	(list-start-char
	 ;; data Contact =  Contact { name :: "asdf" }
	 ;; (unless (eq list-start-char ?{)
	 (cond ((char-equal ?, char)
		'idris-list-separator)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?. char))
		'idris-construct-for-export)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?, char))
		'idris-operator--in-list-continue)
	       ((char-equal ?* char)
		'idris-char-equal-\*-in-list-p)
	       ((member char (list ?\( ?\) ?\]))
		'idris-listing)
	       ((nth 3 pps)
		'idris-and-nth-1-pps-nth-3-pps)
	       ;; ((and (nth 1 pps) (not (member char (list ?, ?\[ ?\] ?\)))))
	       ;; 	'idris-in-list-p)
	       ((and (nth 1 pps)
		     (or (eq (1- (current-column)) (current-indentation))
			 (eq (- (point) 2)(nth 1 pps))))
		'idris-in-list-p)
	       ((and (char-equal ?: char) (looking-back "(.:" (line-beginning-position)))
		'pattern-match-on-list)
	       ))
	;; ((member char (list ?\; ?,)))
	((or (member (char-before (1- (point))) operator-known-operators)
	     (and (eq (char-before (1- (point)))?\s) (member (char-before (- (point) 2)) operator-known-operators)))
	 'idris-join-known-operators)
	((looking-back "<\\*" (line-beginning-position))
	 'idris-<)
	((looking-back "^-" (line-beginning-position))
	 'idris-comment-start)
	((looking-back "lambda +\\_<[^ ]+\\_>:" (line-beginning-position)))
	((looking-back "return +[^ ]+" (line-beginning-position)))
	((looking-back "import +[^ ]+" (line-beginning-position))
	 'idris-import)
	((looking-back "forall +[^ ]+.*" (line-beginning-position)))))

(defun operator--idris-notsecond (char pps list-start-char notsecond)
  (cond (notsecond
	 'idris-notsecond)
	((and (eq char ?.)(looking-back "[ \t]+[0-9]\." (line-beginning-position)))
	 'float)
	((member char (list ?\[  ?\( ?{ ?\] ?\) ?}))
	 'idris-list-delimter)
	((and (eq 'idris-interactive-mode major-mode)
	      (save-excursion (backward-char)
			      (looking-back (concat idris-interactive-prompt " *:[a-z]+ *") (line-beginning-position))))
	 'idris-idris-interactive-prompt)
	((nth 3 pps)
	 'idris-in-string)
	;; index-p
	((and
	  ;; "even <$> (2,2)"
	  (not (char-equal char ?,))
	  (looking-back "^return +[^ ]+.*" (line-beginning-position))))
	((looking-back "^-" (line-beginning-position))
	 'idris-comment-start)
	((looking-back "import +[^ ]+." (line-beginning-position))
	 'idris-import)
	((looking-back "<\\*" (line-beginning-position))
	 'idris->)
	((and (nth 1 pps)
	      (or (eq (1- (current-column)) (current-indentation))
		  (not (string-match "[[:blank:]]" (buffer-substring-no-properties (nth 1 pps) (point))))))
	 'idris-in-list-p)
	(list-start-char
	 ;; data Contact =  Contact { name :: "asdf" }
	 (cond ((char-equal ?, char)
		'idris-list-separator)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?, char))
		'idris-construct-for-export)
	       ((and (char-equal ?: char) (looking-back "(.:" (line-beginning-position)))
		'pattern-match-on-list)))))

(defun operator--do-idris-mode (char orig pps list-start-char &optional notfirst notsecond)
  "Haskell"
  (let* ((notfirst (operator--idris-notfirst char pps list-start-char notfirst))
	 (notsecond (operator--idris-notsecond char pps list-start-char notsecond))
	 (nojoin
	  (cond ((member char (list ?, ?\[ ?\] ?\))))
		((save-excursion (backward-char) (looking-back ") +" (line-beginning-position) ))))))
    (operator--final char orig notfirst notsecond nojoin)))

(defun operator--idris-repl-notfirst (char pps list-start-char notfirst)
  (cond (notfirst
	 'idris-repl-notfirst)
	((and (eq char ?.)(looking-back "[ \t]+[0-9]\." (line-beginning-position)))
	 'float)
	((and (eq 'idris-repl-interactive-mode major-mode)
	      (save-excursion (backward-char 1)
			      (looking-back idris-repl-interactive-prompt (line-beginning-position))))
	 'idris-repl-idris-repl-interactive-prompt)
	(list-start-char
	 ;; data Contact =  Contact { name :: "asdf" }
	 ;; (unless (eq list-start-char ?{)
	 (cond ((char-equal ?, char)
		'idris-repl-list-separator)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?. char))
		'idris-repl-construct-for-export)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?, char))
		'idris-repl-operator--in-list-continue)
	       ((char-equal ?* char)
		'idris-repl-char-equal-\*-in-list-p)
	       ((member char (list ?\( ?\) ?\]))
		'idris-repl-listing)
	       ((nth 3 pps)
		'idris-repl-and-nth-1-pps-nth-3-pps)
	       ;; ((and (nth 1 pps) (not (member char (list ?, ?\[ ?\] ?\)))))
	       ;; 	'idris-repl-in-list-p)
	       ((and (nth 1 pps)
		     (or (eq (1- (current-column)) (current-indentation))
			 (eq (- (point) 2)(nth 1 pps))))
		'idris-repl-in-list-p)
	       ((and (char-equal ?: char) (looking-back "(.:" (line-beginning-position)))
		'pattern-match-on-list)
	       ))
	;; ((member char (list ?\; ?,)))
	((or (member (char-before (1- (point))) operator-known-operators)
	     (and (eq (char-before (1- (point)))?\s) (member (char-before (- (point) 2)) operator-known-operators)))
	 'idris-repl-join-known-operators)
	((looking-back "<\\*" (line-beginning-position))
	 'idris-repl-<)
	((looking-back "^-" (line-beginning-position))
	 'idris-repl-comment-start)
	((looking-back "lambda +\\_<[^ ]+\\_>:" (line-beginning-position)))
	((looking-back "return +[^ ]+" (line-beginning-position)))
	((looking-back "import +[^ ]+" (line-beginning-position))
	 'idris-repl-import)
	((looking-back "forall +[^ ]+.*" (line-beginning-position)))))

(defun operator--idris-repl-notsecond (char pps list-start-char notsecond)
  (cond (notsecond
	 'idris-repl-notsecond)
	((and (eq char ?.)(looking-back "[ \t]+[0-9]\." (line-beginning-position)))
	 'float)
	((member char (list ?\[  ?\( ?{ ?\] ?\) ?}))
	 'idris-repl-list-delimter)
	((and (eq 'idris-repl-interactive-mode major-mode)
	      (save-excursion (backward-char)
			      (looking-back (concat idris-repl-interactive-prompt " *:[a-z]+ *") (line-beginning-position))))
	 'idris-repl-idris-repl-interactive-prompt)
	((nth 3 pps)
	 'idris-repl-in-string)
	;; index-p
	((and
	  ;; "even <$> (2,2)"
	  (not (char-equal char ?,))
	  (looking-back "^return +[^ ]+.*" (line-beginning-position))))
	((looking-back "^-" (line-beginning-position))
	 'idris-repl-comment-start)
	((looking-back "import +[^ ]+." (line-beginning-position))
	 'idris-repl-import)
	((looking-back "<\\*" (line-beginning-position))
	 'idris-repl->)
	((and (nth 1 pps)
	      (or (eq (1- (current-column)) (current-indentation))
		  (not (string-match "[[:blank:]]" (buffer-substring-no-properties (nth 1 pps) (point))))))
	 'idris-repl-in-list-p)
	(list-start-char
	 ;; data Contact =  Contact { name :: "asdf" }
	 (cond ((char-equal ?, char)
		'idris-repl-list-separator)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?, char))
		'idris-repl-construct-for-export)
	       ((and (char-equal ?: char) (looking-back "(.:" (line-beginning-position)))
		'pattern-match-on-list)))))

(defun operator--do-idris-repl-mode (char orig pps list-start-char &optional notfirst notsecond)
  "Haskell"
  (let* ((notfirst (operator--idris-repl-notfirst char pps list-start-char notfirst))
	 (notsecond (operator--idris-repl-notsecond char pps list-start-char notsecond))
	 (nojoin
	  (cond ((member char (list ?, ?\[ ?\] ?\))))
		((save-excursion (backward-char) (looking-back ") +" (line-beginning-position) ))))))
    (operator--final char orig notfirst notsecond nojoin)))

(defun operator--sml-notfirst (char pps list-start-char notfirst)
  (cond (notfirst
	 'sml-notfirst)
	((eq char ?.)
	 'sml-dot)
	;; ((and (eq char ?.)(looking-back "[ \t]+[0-9]\." (line-beginning-position)))
	;; 'float)
	((and (eq 'sml-interactive-mode major-mode)
	      (save-excursion (backward-char 1)
			      (looking-back sml-interactive-prompt (line-beginning-position))))
	 'sml-sml-interactive-prompt)
	(list-start-char
	 ;; data Contact =  Contact { name :: "asdf" }
	 ;; (unless (eq list-start-char ?{)
	 (cond ((char-equal ?, char)
		'sml-list-separator)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?. char))
		'sml-construct-for-export)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?, char))
		'sml-operator--in-list-continue)
	       ((char-equal ?* char)
		'sml-char-equal-\*-in-list-p)
	       ((member char (list ?\( ?\) ?\]))
		'sml-listing)
	       ((nth 3 pps)
		'sml-and-nth-1-pps-nth-3-pps)
	       ;; ((and (nth 1 pps) (not (member char (list ?, ?\[ ?\] ?\)))))
	       ;; 	'sml-in-list-p)
	       ((and (nth 1 pps)
		     (or (eq (1- (current-column)) (current-indentation))
			 (eq (- (point) 2)(nth 1 pps))))
		'sml-in-list-p)
	       ((and (char-equal ?: char) (looking-back "(.:" (line-beginning-position)))
		'pattern-match-on-list)
	       ))
	((member char (list ?\;))
	 'sml-closing-expression)
	((or (member (char-before (1- (point))) operator-known-operators)
	     (and (eq (char-before (1- (point)))?\s) (member (char-before (- (point) 2)) operator-known-operators)))
	 'sml-join-known-operators)
	((looking-back "<\\*" (line-beginning-position))
	 'sml-<)
	((looking-back "^-" (line-beginning-position))
	 'sml-comment-start)
	((looking-back "lambda +\\_<[^ ]+\\_>:" (line-beginning-position)))
	((looking-back "return +[^ ]+" (line-beginning-position)))
	((looking-back "import +[^ ]+" (line-beginning-position))
	 'sml-import)
	((looking-back "forall +[^ ]+.*" (line-beginning-position)))))

(defun operator--sml-notsecond (char pps list-start-char notsecond)
  (cond (notsecond
	 'sml-notsecond)
	((eq char ?.)
	 'sml-dot)
	;; ((and (eq char ?.)(looking-back "[ \t]+[0-9]\." (line-beginning-position)))
	;; 'float)
	((member char (list ?\[  ?\( ?{ ?\] ?\) ?}))
	 'sml-list-delimter)
	((and (eq 'sml-interactive-mode major-mode)
	      (save-excursion (backward-char)
			      (looking-back (concat sml-interactive-prompt " *:[a-z]+ *") (line-beginning-position))))
	 'sml-sml-interactive-prompt)
	((nth 3 pps)
	 'sml-in-string)
	;; index-p
	((and
	  ;; "even <$> (2,2)"
	  (not (char-equal char ?,))
	  (looking-back "^return +[^ ]+.*" (line-beginning-position))))
	((looking-back "^-" (line-beginning-position))
	 'sml-comment-start)
	((looking-back "import +[^ ]+." (line-beginning-position))
	 'sml-import)
	((looking-back "<\\*" (line-beginning-position))
	 'sml->)
	((and (nth 1 pps)
	      (or (eq (1- (current-column)) (current-indentation))
		  (not (string-match "[[:blank:]]" (buffer-substring-no-properties (nth 1 pps) (point))))))
	 'sml-in-list-p)
	(list-start-char
	 ;; data Contact =  Contact { name :: "asdf" }
	 (cond ((char-equal ?, char)
		'sml-list-separator)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?, char))
		'sml-construct-for-export)
	       ((and (char-equal ?: char) (looking-back "(.:" (line-beginning-position)))
		'pattern-match-on-list)))))

(defun operator--do-sml-mode (char orig pps list-start-char &optional notfirst notsecond)
  "Haskell"
  (let* ((notfirst (operator--sml-notfirst char pps list-start-char notfirst))
	 (notsecond (operator--sml-notsecond char pps list-start-char notsecond))
	 (nojoin
	  (cond ((member char (list ?, ?\[ ?\] ?\))))
		((save-excursion (backward-char) (looking-back ") +" (line-beginning-position) ))))))
    (operator--final char orig notfirst notsecond nojoin)))

(defun operator--scala-notfirst (char pps list-start-char notfirst)
  ;; map { y => (x, y) -> x * y })
  (cond (notfirst
	 'scala-notfirst)
	;; EMACS=emacs
        ;; myVar_=
	((and
          ;; (not (eq ?{ list-start-char))
          ;; case ex: IOException => // Handle other I/O error
          (member char (list ?. ?- ?$ ?~ ?_  ?^ ?& ?* 41 ?:)))
	 'scala-punkt)
	((and (eq char ?.) (looking-back "[ \t]+[0-9]\." (line-beginning-position)))
	 'float)
	((and (eq char ?*) (looking-back "[ \t]+[[:alpha:]]*[ \t]*\\*" (line-beginning-position)))
	 'rm-attention)
	((and (or (eq 'shell-interactive-mode major-mode) (eq 'shell-mode major-mode))
	      (save-excursion (backward-char 1)
			      (or
			       (looking-back shell-prompt-pattern (line-beginning-position))
			       ;; (looking-back shell-interactive-prompt (line-beginning-position))
                               )))
	 'scala-shell-interactive-prompt)
	(list-start-char
	 ;; data Contact =  Contact { name :: "asdf" }
	 ;; (unless (eq list-start-char ?{)
	 (cond ((char-equal ?, char)
		'scala-list-separator)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?. char))
		'scala-construct-for-export)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?, char))
		'scala-operator--in-list-continue)
	       ((char-equal ?* char)
		'scala-char-equal-\*-in-list-p)
	       ((member char (list ?\( ?\) ?\]))
		'scala-listing)
	       ((nth 3 pps)
		'scala-and-nth-1-pps-nth-3-pps)
               ;; .settings(name := "muster")
	       ((and (nth 1 pps)
		     (or (eq (1- (current-column)) (current-indentation))
			 (eq (- (point) 2)(nth 1 pps))
                         ;; def main(args: Array[String]): Unit =
                         (and (not (eq list-start-char ?{)) (looking-back "^[ \t]*def[ \t]+.*" (line-beginning-position)))
                         ))
		'scala-in-list-p)
	       ((and (char-equal ?: char) (looking-back "(.:" (line-beginning-position)))
		'pattern-match-on-list)))
	;; ((member char (list ?\; ?,)))
	((or (member (char-before (1- (point))) operator-known-operators)
	     (and (eq (char-before (1- (point)))?\s) (member (char-before (- (point) 2)) operator-known-operators)))
	 'scala-join-known-operators)
	((looking-back "<\\*" (line-beginning-position))
	 'scala-<)
	((looking-back "^-" (line-beginning-position))
	 'scala-comment-start)
	((looking-back "lambda +\\_<[^ ]+\\_>:" (line-beginning-position)))
	((looking-back "return +[^ ]+" (line-beginning-position)))
	((looking-back "import +[^ ]+" (line-beginning-position))
	 'scala-import)
	((looking-back "forall +[^ ]+.*" (line-beginning-position)))))

(defun operator--scala-notsecond (char pps list-start-char notsecond)
  ;; map { y => (x, y) -> x * y })
  ;; (unless (eq ?{ list-start-char)
  (cond (notsecond
	 'scala-notsecond)
	;; EMACS=emacs
	;; :help
	((and
          ;; (not (eq ?{ list-start-char))
          (not (nth 1 pps))
          (member char (list ?: ?. ?- ?$ ?~ ?_ ?^ ?& ?*)))
	 'scala-punkt)
	((and (eq char ?*) (looking-back "[ \t]+[[:alpha:]]*[ \t]*\\*" (line-beginning-position)))
	 'rm-attention)
	((and (eq char ?.) (looking-back "[ \t]+[0-9]\." (line-beginning-position)))
	 'float)
	((member char (list ?\[  ?\( 41))
	 'scala-list-delimiter)
	((and (eq 'shell-interactive-mode major-mode)
	      (save-excursion (backward-char)
			      (looking-back (concat shell-interactive-prompt " *:[a-z]+ *") (line-beginning-position))))
	 'scala-shell-interactive-prompt)
	((nth 3 pps)
	 'scala-in-string)
	;; index-p
	((and
	  ;; "even <$> (2,2)"
	  (not (char-equal char ?,))
	  (looking-back "^return +[^ ]+.*" (line-beginning-position))))
	((looking-back "^-" (line-beginning-position))
	 'scala-comment-start)
        ;; import org.scalatest.{BeforeAndAfterAll,
	((and (looking-back "import +[^ ]+." (line-beginning-position))
              (not (member char (list ?,))))
	 'scala-import)
	((looking-back "<\\*" (line-beginning-position))
	 'scala->)
	((and (nth 1 pps)
              (not (member char (list ?, ?:)))
	      (or
	       (member char (list ?@ ?.))
	       (eq (1- (current-column)) (current-indentation))
               ;; } catch {
	       (and (not (member char (list ?{ ))) (not (string-match "[[:blank:]]" (buffer-substring-no-properties (nth 1 pps) (point)))))))
	 'scala-in-list-p)
	(list-start-char
	 ;; data Contact =  Contact { name :: "asdf" }
	 (cond
          ;; ((char-equal ?, char)
	  ;;       'scala-list-separator)
	  ((and (char-equal ?\[ list-start-char)
		(char-equal ?, char))
	   'scala-construct-for-export)
	  ((and (char-equal ?: char) (looking-back "(.:" (line-beginning-position)))
	   'pattern-match-on-list)))))

(defun operator--do-scala-mode (char orig pps list-start-char &optional notfirst notsecond)
  "Haskell"
  (let* ((notfirst (operator--scala-notfirst char pps list-start-char notfirst))
	 (notsecond (operator--scala-notsecond char pps list-start-char notsecond))
	 (nojoin (cond ((member char (list ?& ?| ?> ?<))
                        nil)
                       ;; case _ => println("huh?")
                       ((and (member char (list ?=))(eq (char-before (1- (point))) ?_))
                        t)
                       (t t))))
    (operator--final char orig notfirst notsecond nojoin)))

(defun operator--scala-shell-notfirst (char pps list-start-char notfirst)
  ;; map { y => (x, y) -> x * y })
  (cond (notfirst
	 'scala-notfirst)
        ((nth 3 pps)
         'in-string)
	;; EMACS=emacs
        ;; s.indexOf.('o')
        ;; <?>,
        ;; 2 * r
	((and (not (eq ?{ list-start-char))(member char (list ?? ?. ?- ?: ?$ ?~ ?_  ?^ ?& ?/ 40 41)))
	 'scala-punkt)
	((and (eq char ?.) (looking-back "[ \t]+[0-9]\." (line-beginning-position)))
	 'float)
	((and (eq char ?*) (looking-back "[ \t]+[[:alpha:]]*[ \t]*\\*" (line-beginning-position)))
	 'rm-attention)
	((and (or (eq 'shell-interactive-mode major-mode) (eq 'shell-mode major-mode))
	      (save-excursion (backward-char 1)
			      (or
			       (looking-back shell-prompt-pattern (line-beginning-position))
			       ;; (looking-back shell-interactive-prompt (line-beginning-position))
                               )))
	 'scala-shell-interactive-prompt)
	((member char (list ?. ?- ?:))
	 'scala-punkt)
	(list-start-char
	 ;; data Contact =  Contact { name :: "asdf" }
	 ;; (unless (eq list-start-char ?{)
	 (cond ((char-equal ?, char)
		'scala-list-separator)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?. char))
		'scala-construct-for-export)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?, char))
		'scala-operator--in-list-continue)
	       ((char-equal ?* char)
		'scala-char-equal-\*-in-list-p)
	       ((member char (list ?\( ?\) ?\]))
		'scala-listing)
	       ((nth 3 pps)
		'scala-and-nth-1-pps-nth-3-pps)

               ;; ("he"+"llo")
	       ((and (nth 1 pps)
		     ;; (or (eq (1- (current-column)) (current-indentation))
			 ;; (eq (- (point) 2)(nth 1 pps))))
		'scala-in-list-p))
	       ((and (char-equal ?: char) (looking-back "(.:" (line-beginning-position)))
		'pattern-match-on-list)))
	;; ((member char (list ?\; ?,)))
	((or (member (char-before (1- (point))) operator-known-operators)
	     (and (eq (char-before (1- (point)))?\s) (member (char-before (- (point) 2)) operator-known-operators)))
	 'scala-join-known-operators)
	((looking-back "<\\*" (line-beginning-position))
	 'scala-<)
	((looking-back "^-" (line-beginning-position))
	 'scala-comment-start)
	((looking-back "lambda +\\_<[^ ]+\\_>:" (line-beginning-position)))
	((looking-back "return +[^ ]+" (line-beginning-position)))
	((looking-back "import +[^ ]+" (line-beginning-position))
	 'scala-import)
	((looking-back "forall +[^ ]+.*" (line-beginning-position)))))

(defun operator--scala-shell-notsecond (char pps list-start-char notsecond)
  ;; map { y => (x, y) -> x * y })
  ;; (unless (eq ?{ list-start-char)
  (cond (notsecond
	 'scala-notsecond)
	;; EMACS=emacs
	;; :help
	((and
          ;; (not (eq ?{ list-start-char))
          (not (nth 1 pps))
           ;; s.indexOf.('o')
          ;; <?>
          ;; x <- y
          ;; 2 * r
          (member char (list ?? ?. ?$ ?~ ?_ ?^ ?& 40 41 ?/)))
	 'scala-punkt)
        ;; method invocation
        ;; val sumMore = (1).+(2)
        ((and
          (not (nth 1 pps))
          (member (char-before (1- (point))) (list ?.)))
	 'method-invocation)
	((and (eq char ?*) (looking-back "[ \t]+[[:alpha:]]*[ \t]*\\*" (line-beginning-position)))
	 'rm-attention)
	((and (eq char ?.) (looking-back "[ \t]+[0-9]\." (line-beginning-position)))
	 'float)
	((member char (list ?\[  ?\())
	 'scala-list-delimter)
	((and (eq 'shell-interactive-mode major-mode)
	      (save-excursion (backward-char)
			      (looking-back (concat shell-interactive-prompt " *:[a-z]+ *") (line-beginning-position))))
	 'scala-shell-interactive-prompt)
	;; ((nth 3 pps)
	;;  'scala-in-string)
	;; index-p
	((and
	  ;; "even <$> (2,2)"
	  (not (char-equal char ?,))
	  (looking-back "^return +[^ ]+.*" (line-beginning-position))))
	((looking-back "^-" (line-beginning-position))
	 'scala-comment-start)
	((looking-back "import +[^ ]+." (line-beginning-position))
	 'scala-import)
	((looking-back "<\\*" (line-beginning-position))
	 'scala->)
	((and (nth 1 pps)
              (not (member char (list ?, ?:)))
	      (or
	       (member char (list ?@ ?. ?\)))
	       (eq (1- (current-column)) (current-indentation))
	       (not (string-match "[[:blank:]]" (buffer-substring-no-properties (nth 1 pps) (point))))))
	 'scala-in-list-p)
	(list-start-char
	 ;; data Contact =  Contact { name :: "asdf" }
	 (cond
          ;; ((char-equal ?, char)
	  ;;       'scala-list-separator)
	  ((and (char-equal ?\[ list-start-char)
		(char-equal ?, char))
	   'scala-construct-for-export)
	  ((and (char-equal ?: char) (looking-back "(.:" (line-beginning-position)))
	   'pattern-match-on-list)))))

(defun operator--do-scala-shell-mode (char orig pps list-start-char &optional notfirst notsecond)
  "Haskell"
  (let* ((notfirst (operator--scala-shell-notfirst char pps list-start-char notfirst))
	 (notsecond (operator--scala-shell-notsecond char pps list-start-char notsecond))
	 (nojoin (unless (member char (list ?& ?| ?= ?> ?<)) t)))
    (operator--final char orig notfirst notsecond nojoin)))

(defun operator--shell-notfirst (char pps list-start-char notfirst)
  (cond (notfirst
	 'shell-notfirst)
	;; EMACS=emacs
        ;; git commit -s -a -m "sdf,
	((member char (list ?- ?: ?$ ?~ ?_ ?= ?^ ?& ?* ?/ ?,))
		'shell-punkt)
        ((and (member char (list ?.)) (save-excursion (backward-char) (not (looking-back  comint-prompt-regexp (point-min)))))
         'shell-punkt-not-at-prompt)
	((and (eq char ?.)(looking-back "[ \t]+[0-9]\." (line-beginning-position)))
	 'float)
	((and (eq char ?*)(looking-back "[ \t]+[[:alpha:]]*[ \t]*\\*" (line-beginning-position)))
	 'rm-attention)
	((and (or (eq 'shell-interactive-mode major-mode)(eq 'shell-mode major-mode))
	      (save-excursion (backward-char 1)
			      (or
			       (looking-back shell-prompt-pattern (line-beginning-position))
			       ;; (looking-back shell-interactive-prompt (line-beginning-position))
			       )))
	 'shell-shell-interactive-prompt)
	(list-start-char
	 ;; data Contact =  Contact { name :: "asdf" }
	 ;; (unless (eq list-start-char ?{)
	 (cond ((char-equal ?, char)
		'shell-list-separator)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?. char))
		'shell-construct-for-export)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?, char))
		'shell-operator--in-list-continue)
	       ((char-equal ?* char)
		'shell-char-equal-\*-in-list-p)
	       ((member char (list ?\( ?\) ?\]))
		'shell-listing)
	       ((nth 3 pps)
		'shell-and-nth-1-pps-nth-3-pps)
	       ;; ((and (nth 1 pps) (not (member char (list ?, ?\[ ?\] ?\)))))
	       ;; 	'shell-in-list-p)
	       ((and (nth 1 pps)
		     (or (eq (1- (current-column)) (current-indentation))
			 (eq (- (point) 2)(nth 1 pps))))
		'shell-in-list-p)
	       ((and (char-equal ?: char) (looking-back "(.:" (line-beginning-position)))
		'pattern-match-on-list)
	       ))
	;; ((member char (list ?\; ?,)))
	((unless 
             (save-excursion (backward-char) (looking-back  comint-prompt-regexp (point-min)))
           (or (member (char-before (1- (point))) operator-known-operators)
	       (and (eq (char-before (1- (point)))?\s) (member (char-before (- (point) 2)) operator-known-operators))))
	 'shell-join-known-operators)
	((looking-back "<\\*" (line-beginning-position))
	 'shell-<)
	((looking-back "^-" (line-beginning-position))
	 'shell-comment-start)
	((looking-back "lambda +\\_<[^ ]+\\_>:" (line-beginning-position)))
	((looking-back "return +[^ ]+" (line-beginning-position)))
	((looking-back "import +[^ ]+" (line-beginning-position))
	 'shell-import)
	((looking-back "forall +[^ ]+.*" (line-beginning-position)))))

(defun operator--shell-notsecond (char pps list-start-char notsecond)
  (cond (notsecond
	 'shell-notsecond)
	;; EMACS=emacs
	((member char (list ?. ?- ?: ?$ ?~ ?_ ?= ?^ ?& ?* ?/))
		'shell-punkt)
	((and (eq char ?*)(looking-back "[ \t]+[[:alpha:]]*[ \t]*\\*" (line-beginning-position)))
	 'rm-attention)
	((and (eq char ?.)(looking-back "[ \t]+[0-9]\." (line-beginning-position)))
	 'float)
	((member char (list ?\[  ?\( ?{ ?\] ?\) ?}))
	 'shell-list-delimter)
	((and (eq 'shell-interactive-mode major-mode)
	      (save-excursion (backward-char)
			      (looking-back (concat shell-interactive-prompt " *:[a-z]+ *") (line-beginning-position))))
	 'shell-shell-interactive-prompt)
        ;; git commit -s -a -m "sdf,
	;; ((nth 3 pps)
	;;  'shell-in-string)
	;; index-p
	((and
	  ;; "even <$> (2,2)"
	  (not (char-equal char ?,))
	  (looking-back "^return +[^ ]+.*" (line-beginning-position))))
	((looking-back "^-" (line-beginning-position))
	 'shell-comment-start)
	((looking-back "import +[^ ]+." (line-beginning-position))
	 'shell-import)
	((looking-back "<\\*" (line-beginning-position))
	 'shell->)
	((and (nth 1 pps)
	      (or
	       (member char (list ?@))
	       (eq (1- (current-column)) (current-indentation))
		  (not (string-match "[[:blank:]]" (buffer-substring-no-properties (nth 1 pps) (point))))))
	 'shell-in-list-p)
	(list-start-char
	 ;; data Contact =  Contact { name :: "asdf" }
	 (cond ((char-equal ?, char)
		'shell-list-separator)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?, char))
		'shell-construct-for-export)
	       ((and (char-equal ?: char) (looking-back "(.:" (line-beginning-position)))
		'pattern-match-on-list)))))

(defun operator--do-shell-mode (char orig pps list-start-char &optional notfirst notsecond)
  "Shell-mode"
  (let* ((notfirst (operator--shell-notfirst char pps list-start-char notfirst))
	 (notsecond (operator--shell-notsecond char pps list-start-char notsecond))
	 (nojoin (unless (member char (list ?& ?| ?= ?> ?<)) t)))
    (operator--final char orig notfirst notsecond nojoin)))

(defun operator--coq-notfirst (char pps list-start-char notfirst)
  (cond (notfirst
	 'coq-notfirst)
	((and (eq 'coq-interactive-mode major-mode)
	      (save-excursion (backward-char 1)
			      (looking-back coq-interactive-prompt (line-beginning-position))))
	 'coq-coq-interactive-prompt)
	(list-start-char
	 ;; data Contact =  Contact { name :: "asdf" }
	 ;; (unless (eq list-start-char ?{)
	 (cond ((char-equal ?, char)
		'coq-list-separator)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?. char))
		'coq-construct-for-export)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?, char))
		'coq-operator--in-list-continue)
	       ((char-equal ?* char)
		'coq-char-equal-\*-in-list-p)
	       ((member char (list ?\( ?\) ?\]))
		'coq-listing)
	       ((nth 3 pps)
		'coq-and-nth-1-pps-nth-3-pps)
	       ;; ((and (nth 1 pps) (not (member char (list ?, ?\[ ?\] ?\)))))
	       ;; 	'coq-in-list-p)
	       ((and (nth 1 pps)
		     (or (eq (1- (current-column)) (current-indentation))
			 (eq (- (point) 2)(nth 1 pps))))
		'coq-in-list-p)
	       ((and (char-equal ?: char) (looking-back "(.:" (line-beginning-position)))
		'pattern-match-on-list)
	       ))
	;; ((member char (list ?\; ?,)))
	((or (member (char-before (1- (point))) operator-known-operators)
	     (and (eq (char-before (1- (point)))?\s) (member (char-before (- (point) 2)) operator-known-operators)))
	 'coq-join-known-operators)
	((looking-back "<\\*" (line-beginning-position))
	 'coq-<)
	((looking-back "^-" (line-beginning-position))
	 'coq-comment-start)
	((looking-back "lambda +\\_<[^ ]+\\_>:" (line-beginning-position)))
	((looking-back "return +[^ ]+" (line-beginning-position)))
	((looking-back "import +[^ ]+" (line-beginning-position))
	 'coq-import)
	((looking-back "forall +[^ ]+.*" (line-beginning-position)))))

(defun operator--coq-notsecond (char pps list-start-char notsecond)
  (cond (notsecond
	 'coq-notsecond)
	((member char (list ?\[  ?\( ?{ ?\] ?\) ?}))
	 'coq-list-delimter)
	((and (eq 'coq-interactive-mode major-mode)
	      (save-excursion (backward-char)
			      (looking-back (concat coq-interactive-prompt " *:[a-z]+ *") (line-beginning-position))))
	 'coq-coq-interactive-prompt)
	((nth 3 pps)
	 'coq-in-string)
	;; index-p
	((and
	  ;; "even <$> (2,2)"
	  (not (char-equal char ?,))
	  (looking-back "^return +[^ ]+.*" (line-beginning-position))))
	((looking-back "^-" (line-beginning-position))
	 'coq-comment-start)
	((looking-back "import +[^ ]+." (line-beginning-position))
	 'coq-import)
	((looking-back "<\\*" (line-beginning-position))
	 'coq->)
	((and (nth 1 pps)
	      (or (eq (1- (current-column)) (current-indentation))
		  (not (string-match "[[:blank:]]" (buffer-substring-no-properties (nth 1 pps) (point))))))
	 'coq-in-list-p)
	(list-start-char
	 ;; data Contact =  Contact { name :: "asdf" }
	 (cond ((char-equal ?, char)
		'coq-list-separator)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?, char))
		'coq-construct-for-export)
	       ((and (char-equal ?: char) (looking-back "(.:" (line-beginning-position)))
		'pattern-match-on-list)))))

(defun operator--do-coq-mode (char orig pps list-start-char &optional notfirst notsecond)
  "Haskell"
  (let* ((notfirst (operator--coq-notfirst char pps list-start-char notfirst))
	 (notsecond (operator--coq-notsecond char pps list-start-char notsecond))
	 (nojoin
	  (cond ((member char (list ?, ?\[ ?\] ?\))))
		((save-excursion (backward-char) (looking-back ") +" (line-beginning-position) ))))))
    (operator--final char orig notfirst notsecond nojoin)))

(defun operator--agda-notfirst (char pps list-start-char notfirst)
  (cond (notfirst
	 'agda-notfirst)
	((and (eq 'agda-interactive-mode major-mode)
	      (save-excursion (backward-char 1)
			      (looking-back agda-interactive-prompt (line-beginning-position))))
	 'agda-agda-interactive-prompt)
	(list-start-char
	 ;; data Contact =  Contact { name :: "asdf" }
	 ;; (unless (eq list-start-char ?{)
	 (cond ((char-equal ?, char)
		'agda-list-separator)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?. char))
		'agda-construct-for-export)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?, char))
		'agda-operator--in-list-continue)
	       ((char-equal ?* char)
		'agda-char-equal-\*-in-list-p)
	       ((member char (list ?\( ?\) ?\]))
		'agda-listing)
	       ((nth 3 pps)
		'agda-and-nth-1-pps-nth-3-pps)
	       ((and (nth 1 pps) (not (member char (list ?: ?, ?\[ ?\] ?\)))))
		'agda-in-list-p)))
	;; ((member char (list ?\; ?,)))
	((or (member (char-before (1- (point))) operator-known-operators)
	     (and (eq (char-before (1- (point)))?\s) (member (char-before (- (point) 2)) operator-known-operators)))
	 'agda-join-known-operators)
	((looking-back "<\\*" (line-beginning-position))
		'agda-<)
	((looking-back "^-" (line-beginning-position))
	 'agda-comment-start)
	((looking-back "lambda +\\_<[^ ]+\\_>:" (line-beginning-position)))
	((looking-back "return +[^ ]+" (line-beginning-position)))
	((looking-back "import +[^ ]+" (line-beginning-position))
	 'agda-import)
	((looking-back "forall +[^ ]+.*" (line-beginning-position)))))

(defun operator--agda-notsecond (char pps list-start-char notsecond)
  (cond (notsecond)
	((or (char-equal ?\[ char) (char-equal ?\( char))
	 'agda-list-opener)
	((and (eq 'agda-interactive-mode major-mode)
	      (save-excursion (backward-char)
			      (looking-back (concat agda-interactive-prompt " *:[a-z]+ *") (line-beginning-position))))
	 'agda-agda-interactive-prompt)
	(list-start-char
	 ;; data Contact =  Contact { name :: "asdf" }
	 (cond ((char-equal ?, char)
		'agda-list-separator)
	       ((and (char-equal ?\[ list-start-char)
		     (char-equal ?, char))
		'agda-construct-for-export)
	       ((and (nth 1 pps) (not (member char (list ?: ?,))))
		'agda-in-list-p)))
	((nth 3 pps)
	 'agda-in-string)
	((member char (list ?\( 41 93))
	 'agda-listing)
	;; index-p
	((and
	  ;; "even <$> (2,2)"
	  (not (char-equal char ?,))
	  (looking-back "^return +[^ ]+.*" (line-beginning-position))))
	((looking-back "^-" (line-beginning-position))
	 'agda-comment-start)
	((looking-back "import +[^ ]+." (line-beginning-position))
	 'agda-import)
	((looking-back "<\\*" (line-beginning-position))
	 'agda->)))

(defun operator--do-agda-mode (char orig pps list-start-char &optional notfirst notsecond)
  "Haskell"
  (let* ((notfirst (operator--agda-notfirst char pps list-start-char notfirst))
	 (notsecond (operator--agda-notsecond char pps list-start-char notsecond))
	 (nojoin
	  (cond ((member char (list ?, ?\[ ?\] ?\))))
		((save-excursion (backward-char) (looking-back ") +" (line-beginning-position) ))))))
    (operator--final char orig notfirst notsecond nojoin)))

(defun operator--org-notfirst (char pps list-start-char notfirst)
  (cond (notfirst 'org-notfirst)
	((nth 1 pps)
	 'org-in-list-p)
	((char-equal ?, char)
	 'org-list-separator)
	((member char (list ?$ ?\; ?, ?. ?: ?\? ?! ?@ ?- 47))
	 (unless
             (or
              (looking-back "^\\* *." (line-beginning-position))
              (and (eq char ?-) (looking-back " .-" (line-beginning-position))))
	   'org-punct-class))
	((looking-back "[[:alpha:]äöüß.]")
	 'org-in-word)
	((char-equal ?* char)
	 'org-char-equal-\*-in-list-p)
	((member char (list ?\( ?\) ?\] 47))
	 'org-listing)
	((nth 3 pps)
	 'org-and-nth-1-pps-nth-3-pps)
	((and (nth 1 pps) (not (member char (list ?: ?, ?\[ ?\] ?\)))))
	 'org-in-list-p)
	;; ((member char (list ?\; ?,)))
	((or (member (char-before (1- (point))) operator-known-operators)
	     (and (eq (char-before (1- (point)))?\s) (member (char-before (- (point) 2)) operator-known-operators)))
	 'org-join-known-operators)
	((looking-back "^<s?" (line-beginning-position))
	 'org-src-block)
	((looking-back "^ *#\\+TBLFM:.*" (line-beginning-position))
	 'org-TBLFM)))

(defun operator--org-notsecond (char pps list-start-char notsecond)
  (cond (notsecond
	 'org-notsecond)
	;; ((nth 1 pps)
	;;  'org-in-list-p)
	;; ((looking-back "[[:alpha:]äöüß.-]")
	;;  'org-in-word)
	((nth 3 pps)
	 'org-in-string)
	((member char (list ?\[ ?\] ?\( ?\) ?\/))
	 'org-listing)
	((member char (list ?$ ?@ ?- ?: ?.))
	 'org-punct-class)
	;; index-p
	((and
	  ;; "even <$> (2,2)"
	  (not (char-equal char ?,))
	  (looking-back "^return +[^ ]+.*" (line-beginning-position))))
	((looking-back "^<s?" (line-beginning-position))
	 'org-src-block)
	((looking-back "^ *#\\+TBLFM:.*" (line-beginning-position))
	 'org-TBLFM)))

(defun operator--do-org-mode (char orig pps list-start-char &optional notfirst notsecond)
  "Haskell"
  (let* ((notfirst (operator--org-notfirst char pps list-start-char notfirst))
	 (notsecond (operator--org-notsecond char pps list-start-char notsecond))
	 (nojoin
	  (cond ((member char (list ?, ?\[ ?\] ?\))))
		((save-excursion (backward-char) (looking-back ") +" (line-beginning-position))))
                ((and (eq major-mode 'org-mode) (looking-back "^\\* *." (line-beginning-position)))))))
    (operator--final char orig notfirst notsecond nojoin)))


(defun operator--text-notfirst (char start pps list-start-char notfirst)
  (cond (notfirst
	 'text-notfirst)
	((member char (list ?\; ?\( ?, ?. ?: ?\? ?! ?@ ?- 47))
	 'text-punct-class)
	((or (member (char-before (1- (point))) operator-known-operators)
	     (and (eq (char-before (1- (point)))?\s) (member (char-before (- (point) 2)) operator-known-operators)))
	 'text-join-known-operators)
	((member char (list ?*))
	 'text-org-special)
	((looking-back "[[:alpha:]äöüß.]")
	 'text-in-word)))

(defun operator--text-notsecond (char start pps list-start-char notsecond)
  (cond (notsecond)
	((looking-back "[[:alnum:]][-/öäüßÄÖÜ]")
	 'text-in-word)
	((member char (list ?@))
	 'text-et)
	((member char (list ?.))
	 'text-dot)
	((member char (list ?\[ ?{ ?\( ?\" ?'))
	 'text-open-paren)
	((nth 3 pps)
	 'text-in-string)
	))

(defun operator--do-text-mode (char orig pps list-start-char &optional notfirst notsecond)
  "Haskell"
  (let* ((notfirst
	  (operator--text-notfirst char orig pps list-start-char notfirst))
	 (notsecond
	  (operator--text-notsecond char orig pps list-start-char  notsecond))
	 (nojoin
	  (cond ((member char (list ?, ?\[ ?\] ?\))))
		((save-excursion (backward-char) (looking-back ") +" (line-beginning-position)))))))
    (operator--final char orig notfirst notsecond nojoin)))

(defun operator--join-operators-maybe (char)
  ;; (skip-chars-backward operator-known-operators-strg)
  (and (or (eq (char-before (- (point) 1)) 32)
	   ;; print("Fehler: Richig war " ++
	   (eq (char-before) char)
	   )
       ;; ∅ ->
       ;; _+_ = ;; agda
       (not (member (char-before (- (point) 1)) (list ?∅ ?_)))
       (or (member (char-before (- (point) 2)) operator-known-operators)
	   (member (char-before (- (point) 1)) operator-known-operators))
       (not (ignore-errors (eq (char-syntax (char-before (- (point) 2))) 41)))
       (save-excursion (backward-char)
		       (and (eq (char-before) 32)(delete-char -1))
		       t)))

(defun operator--final (char orig &optional notfirst notsecond nojoin fix-whitespace)
  ;; (when (member char operator-known-operators)

  (cond (notfirst
	 (unless nojoin (operator--join-operators-maybe char)))
	((not notfirst)
	 (or (unless nojoin (operator--join-operators-maybe char))
	     (save-excursion (goto-char (1- orig))
			     (unless (eq (char-before) ?\s)
			       (just-one-space))))))
  (unless notsecond
    (if (eq (char-after) ?\s)
	(forward-char 1)
      (just-one-space)))
  (when fix-whitespace (delete-horizontal-space)))

(defun operator--do-intern (char orig)
  (let* ((min (cond ((member major-mode (list 'shell-mode 'py-shell-mode 'inferior-python-mode))
		     (or (cdr comint-last-prompt) (line-beginning-position)))
		    ((eq major-mode 'haskell-interactive-mode)
		     haskell-interactive-mode-prompt-start)
		    (t (point-min))))
	 (pps (parse-partial-sexp min (point)))
	 (list-start-char
	  (and (nth 1 pps) (save-excursion
			     (goto-char (nth 1 pps)) (char-after))))
	 (notfirst
	  (cond ((and (member char (list ?@ ?> ?.)) (looking-back (concat "<[[:alnum:]_@.]+" (char-to-string char)) (line-beginning-position)))
		 'email-adress)
                ;; join
		;; ((and (member char (list ?= ?:))
                ;;       (or
                ;;        (not (eq major-mode 'scala-mode))
                ;;        ;; (or (member (char-before (1- (point))) operator-known-operators)
                ;;        ;;     (and (member (char-before (+ (point) 2)) operator-known-operators)
                ;;        ;;          (eq (char-before (1- (point))) 32)))
                ;;        )
                ;;       ;; case _ => println("huh?")
                ;;       )
                ;;  'operator-mode-combined-assigment-1)
                ;; join
                ;;  def main(args: Array[String]):
                ((unless
                     (or
                      (and (eq major-mode 'org-mode) (looking-back "^\\* .*" (line-beginning-position)))
                      ;; firstArg match {
                      ;;   case "eggs" => println("bacon")
                      ;;   case _ =
                      (and (eq major-mode 'scala-mode)
                           (and (member (char-before (+ (point) 2)) operator-known-operators)
                                (eq (char-before (1- (point))) 32))))
                   (and (eq 32 (char-before (1- (point))))
                        (member (char-before (- (point) 2)) operator-known-operators)))
                 (save-excursion
                   (goto-char (- (point) 2))
                   (delete-char 1))
                 'operator-mode-combined-assigment-2)
	        ((and
                  (member char (list ?`))
                  (or
                   (not (< 0 (% (count-matches "`" (line-beginning-position) (point)) 2)))
                   (eq (char-before (1- (point))) 32)))
	         'generic-on-symbols)))
         (notsecond
          (cond
           ((and
             (member char (list ?`))
             ;; odd numbers of backticks before last one
             (< 0 (% (count-matches "`" (line-beginning-position) (point)) 2))
             ;; (eq (char-before (1- (point))) 32)
             )
            'generic-on-symbols)
           ((and (member char (list ?@ ?> ?.)) (looking-back (concat "<[[:alnum:]_@.]+" (char-to-string char)) (line-beginning-position)))
            'email-adress))))
    ;; generic settings above
    (pcase major-mode
      (`agda2-mode
       (operator--do-agda-mode char orig pps list-start-char notfirst notsecond))
      (`coq-mode
       (operator--do-coq-mode char orig pps list-start-char notfirst notsecond))
      (`haskell-mode
       (operator--do-haskell-mode char orig pps list-start-char notfirst notsecond))
      (`idris-mode
       (operator--do-idris-mode char orig pps list-start-char notfirst notsecond))
      (`idris-repl-mode
       (operator--do-idris-repl-mode char orig pps list-start-char notfirst notsecond))
      (`haskell-interactive-mode
       (operator--do-haskell-interactive-mode char orig pps list-start-char notfirst notsecond))
      (`inferior-haskell-mode
       (operator--do-haskell-interactive-mode char orig pps list-start-char notfirst notsecond))
      (`java-mode
       (operator--do-java-mode char orig pps list-start-char notfirst notsecond))
      (`org-mode
       (operator--do-org-mode char orig pps list-start-char notfirst notsecond))
      (`python-mode
       (operator--do-python-mode char orig pps list-start-char notfirst notsecond))
      (`py-shell-mode
       (operator--do-python-mode char orig pps list-start-char notfirst notsecond))
      (`py-ipython-shell-mode
       (operator--do-python-mode char orig pps list-start-char notfirst notsecond))
      (`scala-mode
       (operator--do-scala-mode char orig pps list-start-char notfirst notsecond))
      (`shell-mode
       ;; (if (ignore-errors (shell-command ":sh env"))
       ;; (operator--do-scala-shell-mode char orig pps list-start-char notfirst notsecond)
       (operator--do-shell-mode char orig pps list-start-char notfirst notsecond))
      (`sml-mode
       (operator--do-sml-mode char orig pps list-start-char notfirst notsecond))
      (`inferior-sml-mode
       (operator--do-sml-mode char orig pps list-start-char notfirst notsecond))
      (`sql-mode
       (operator--do-sql-mode char orig pps list-start-char notfirst notsecond))
      (`text-mode
       (operator--do-text-mode char orig pps list-start-char notfirst notsecond))
      (`english-mode
       (operator--do-text-mode char orig pps list-start-char notfirst notsecond))
      ((pred derived-mode-p)
       (operator--do-text-mode char orig pps list-start-char notfirst notsecond))
      (_ (operator--final char orig notfirst notsecond)))))

(defun operator-do ()
  "Act according to operator before point, if any."
  (interactive "*")
  (and  (member (char-before) operator-known-operators)
	(or
	 ;; must not check if allowed anyway
	 operator-mode-in-comment-p
         operator-mode-in-string-p
         ;; p : filterPrime [x|
	 ;; (and (member major-mode (list 'haskell-mode 'haskell-interactive-mode))(eq (char-before) ?|))
         (not (nth 8 (parse-partial-sexp (point-min) (point)))))
	(operator--do-intern (char-before) (copy-marker (point)))))

(define-minor-mode operator-mode
  "Toggle automatic insertion of spaces around operators if appropriate.

With a prefix argument ARG, enable Electric Spacing mode if ARG is
positive, and disable it otherwise. If called from Lisp, enable
the mode if ARG is omitted or nil.

This is a local minor mode.  When enabled, typing an operator automatically
inserts surrounding spaces, e.g., `=' might become ` = ',`+=' becomes ` += '.

With prefix-key ‘C-q’ inserts character literally."
  :global nil
  :group 'electricity
  :lighter " _~_ "

  ;; body
  (if operator-mode
      (progn ;; (operator-setup)
	     (add-hook 'post-self-insert-hook
                       ;; #'operator-post-self-insert-function nil t)
		       #'operator-do nil t))
    (remove-hook 'post-self-insert-hook
		 ;; #'operator-post-self-insert-function t)))
		 #'operator-do t)))

(provide 'operator-mode)
;;; operator-mode.el ends here
