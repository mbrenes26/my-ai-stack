# Workflow: xmy-create_markdown_chapter

Purpose

* Operator-driven workflow to collect context (text + images) across multiple chat messages and compile them into **one Markdown chapter** only after explicit confirmation.
* The agent will 1) **prompt for a filename immediately** after the trigger, and 2) ask to enter the text content, 3) **acknowledge each context message**, reminding the operator it is waiting for `#writemd`.

---

## How YOU run it (operator perspective)

1. The agent **asks for the filename** immediately. Reply with:

```
$filename="<PUT_FILENAME>.md"
```
    ## Filename Pattern Format

    Follow this simple, consistent pattern for all Markdown files:

    ```
    #.##.##_<title_with_underscores>.md
    ```

    ### Structure

    | Part                       | Meaning                            | Example              |
    | -------------------------- | ---------------------------------- | -------------------- |
    | `#`                        | Major chapter number               | `1`                  |
    | `##`                       | Subchapter number                  | `01`                 |
    | `##`                       | Subsection number                  | `02`                 |
    | `_`                        | Separator                          | `_`                  |
    | `<title_with_underscores>` | Short, lowercase title (no spaces) | `data_visualization` |
    | `.md`                      | Markdown extension                 | `.md`                |

    ### Rules

    1. Use **leading zeros** (`01`, `02`) for sorting.
    2. Use **underscores**, never spaces or dashes.
    3. Keep titles **short and lowercase**.
    4. Always end with `.md`.

    ### Example

    ```
    2.03.01_probability_distributions.md
    ```


3. **Feed context**: paste any text, screenshots, quiz Q&A, and notes in separate messages. After **each** message you send, the agent replies with a short acknowledgement like:

```
Context received. Waiting for #writemd to generate the chapter.
```

4. **Confirm** when ready by sending this exact hashtag on its own line:

```
#writemd
```

5. After the hashtag, the assistant compiles a **single Markdown chapter** and generates the file using the selected filename. The full text will **not** be echoed back in chat.

---

## Output Rules (enforced at generation time)

* **ASCII-only** output (no emojis).
* **Clear sections** with concise headings.
* **Examples included** for each key concept.
* **Quiz questions** become **brief explanations with answers**.
* **Formulas** in plain text (e.g., `E = mc^2`, `y = w^T x + b`).
* Uses the filename provided via `$filename`; defaults to `chapter.md` if not set.

---

## Notes Authoring Prompt (English)

Use the following prompt to shape the generated notes. Because of ASCII-only rules, replace any emoji with ASCII equivalents (e.g., `?`, `!!`, `NOTE`).

```
You are writing personal study notes for a course. Use the following tone and style:

TONE:
- Informal and practical - write as you naturally think and speak
- Clear and direct - get straight to the point
- Personal - these notes are for YOU, not for the professor

FORMATTING:
- Use short phrases and bullet points instead of complete sentences
- Use abbreviations that make sense to you
- Highlight key information with emphasis (bold/underline with ASCII conventions)
- Use titles and subtitles to organize content
- Number or use bullet points for lists
- Leave space to add information later

CONTENT APPROACH:
- Write in your own words rather than copying verbatim
- Include examples that help you remember concepts
- Mark doubts or questions with ASCII markers like "?", "NOTE", "WARNING"
- Note connections to other topics: "this relates to ..."
- Focus on what's essential and important

EXAMPLES:
- WRONG: "The professor mentioned that the concept of X is fundamental for ..."
- RIGHT:  "X is key because ..."
- RIGHT:  "IMPORTANT: X affects Y - see example p. 45"

Remember: These notes should make immediate sense when you review them later for studying or exams.
```

---

## Suggested Section Skeleton (for the generated chapter)

```
# <Chapter Title>

## Overview
Short summary of the topic and scope.

## Key Concepts
- <concept 1>
- <concept 2>

## Worked Examples
- Example 1: steps
- Example 2: steps

## Quiz Insights (brief Q&A explanations)
- Q1: <short restatement>
  - Answer / reasoning in 2-4 lines.
- Q2: <short restatement>
  - Answer / reasoning in 2-4 lines.

## Formulas (plain text)
- Example: y = w^T x + b
- Example: cross_entropy = -sum(y_true * log(y_pred))

## Summary
- 3-5 key takeaways

## References
- Optional links or citations (no proprietary media)
```

---

## Example Run (operator flow)

```
/xdc_create_markdown_chapter.md
$filename="Quiz - Deep Learning.md"
[Paste notes]
=> Agent: Context received. Waiting for #writemd to generate the chapter.
[Paste images or their descriptions]
=> Agent: Context received. Waiting for #writemd to generate the chapter.
#writemd
```

Result: A new file named `Quiz - Deep Learning.md` containing the compiled chapter.

---

## Notes

* The workflow only starts **compilation** after `#writemd` is seen.
* If you continue sending messages **after** `#writemd`, they are **not** included unless you re-run the workflow.
* Proprietary media is **not** embedded; reference private l
