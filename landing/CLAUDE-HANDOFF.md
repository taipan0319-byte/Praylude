# Praylude landing page

Use this complete static landing page as the design and content source. It includes responsive CSS, accessible navigation, a sourced Gospel excerpt, the original Day 1 prayer, expandable reflections and practical articles, and two generated photographic illustrations.

## Files

- `index.html`: readable HTML and CSS, suitable for pasting into Claude. Keep `assets/` beside it.
- `assets/church.png`: generated church photograph.
- `assets/coffee.png`: generated cafe photograph.
- A separate `praylude-landing-single-file.html` contains embedded copies of both images. It can open by itself without external image files. Prefer the smaller index.html and assets for repository maintenance.

## Integration

1. Inspect the current Praylude repository and Pages deployment before changing files.
2. Preserve the Flutter app and its build. Do not overwrite the app's existing index.html with this marketing page.
3. Put this landing page at a distinct route, such as `/Praylude/welcome/`, keeping its assets together. The exact route should follow the existing deployment structure.
4. All links marked `data-app-link` currently point to `https://taipan0319-byte.github.io/Praylude/`. If the app is moved, update every one consistently. Ensure the landing page cannot link back to itself by mistake.
5. Retain the supplied copy and visual design initially. Browser-test desktop and iPhone widths, keyboard navigation, native disclosure controls, and app links before publishing. Actual browser rendering has not been QA-tested in the delivered package; structural checks were performed.
6. The page does not collect email addresses or install analytics. If Ryan chooses to restore the waitlist experiment, connect his actual Formspree endpoint and approved analytics configuration. Do not add a pretend success message or unconnected signup form.

## Editorial notes

- The main CTA says "Begin praying" and opens the existing browser prototype. It is labeled as an early preview, not a finished App Store release.
- The novena tracker shown on this landing page is a clearly labeled illustrative example, not stored user progress.
- Daily reminders are described as planned for the native app.
- No claims are made about journal security, testimonials, signup counts, Church approval, or guaranteed marriage.
- The Scripture excerpt is Matthew 7:7, following the NABRE wording at https://bible.usccb.org/bible/matthew/7. Review publication requirements before public release. Do not silently switch translations.
- The Day 1 prayer and the short reflections are original Praylude editorial drafts from Ryan's work with ChatGPT. No third-party novena text has been copied into this page.

## Image provenance

Both photographs were created with the built-in image-generation tool, one generation per asset. These are fictional illustrative scenes, not documentation of a real church, event, couple, or endorsement. The footer identifies the photography as AI-created.

Prompts:

1. Photorealistic editorial Catholic church, rear central aisle, late afternoon light across wooden pews, clear distant crucifix, warm stone and burgundy shadows, no people or text; central composition for an arch crop.
2. Candid editorial man and woman in their late twenties/early thirties enjoying coffee and friendly conversation at a sidewalk cafe, natural light, realistic skin, tasteful clothes, subtle film quality; fictional illustration, no rings, branding, text, or UI.

The second image includes a small ring despite that prompt detail. It is used as a general scene of conversation, without claiming to depict actual singles or a first date.
