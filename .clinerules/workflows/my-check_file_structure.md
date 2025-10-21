# Markdown File Structure and Quality Rules (Updated)

This document defines the **expected structure and formatting rules** for all Markdown chapters in this repository.  
It ensures **consistency**, **clarity**, and **readability** across all study materials.

---

## 1. File Naming Convention

**Pattern:**  
```
#.##.##_Title_with_underscores.md
```

**Rules:**
- Use **leading zeros** for subchapters (e.g., `01`, `02`).
- Use **underscores** instead of spaces or dashes.
- Keep titles **short and lowercase**.
- Always end with `.md`.

**Example:**  
```
1.01.04_operations_on_matrices.md
```

---

## 2. File Structure Overview

Each Markdown file should follow a **consistent hierarchical structure**:

```
# <Chapter Title>

## Context (optional)
Detailed description of the video or lesson this file accompanies.

## Overview
Detailed summary of the topic and its importance.

## Key Concepts
- Bullet list of main ideas or definitions. Explain with your objective perspective.

## Worked Examples
- Example 1: step-by-step explanation
- Example 2: additional demonstration

## Quiz Insights (if applicable)
- Q1: <short restatement>
  - Answer / reasoning in 2–4 lines.

## Formulas (plain text)
- Example: y = w^T x + b
- Example: cross_entropy = -sum(y_true * log(y_pred))

## Summary
- 3–5 key takeaways summarizing the section.

## References
- Optional links or citations (no proprietary media)
```

---

## 3. Section-Level Rules

### 3.1 Titles and Headings
- Use **H1** for the main title (`#`).
- Use **H2** for major sections (`##`).
- Use **H3** only when necessary for subtopics.
- Include **timestamps** (e.g., `[00:05]`) for video-based sections when applicable.
- For video-based lessons, include timestamps in subsection titles to align with video segments.

### 3.2 Code Blocks
- Use fenced code blocks with language identifiers:
  ```python
  print("Hello, world!")
  ```
- Include **inline comments** to clarify output or purpose.
- Avoid unnecessary repetition of imports unless conceptually required.
- Maintain **chronological flow** of examples when aligned with instructional media.

### 3.3 Lists and Bullets
- Use `-` for unordered lists.
- Use `1.` for ordered lists when sequence matters.
- Keep items **concise** and **parallel in structure**.

### 3.4 Notes and Warnings
- Use ASCII markers only:
  - `NOTE:` for important remarks.
  - `WARNING:` for potential pitfalls.
  - Avoid emojis or non-ASCII symbols.

---

## 4. Content Guidelines

### 4.1 Tone and Style
- Write in a **clear, direct, and practical** tone.
- Use **short phrases** or **bullet points** instead of long paragraphs.
- Focus on **key ideas** and **examples** rather than theory-heavy text.

### 4.2 Examples
- Every concept should include **at least one example**.
- Examples must be **runnable** and **self-contained**.
- Prefer **NumPy**, **Pandas**, or **Python standard library** examples for consistency.
- Maintain logical or chronological order when examples correspond to instructional media.

### 4.3 Summary Section
- Required in every file.
- Should include **3–5 concise takeaways** summarizing the main learning points.
- Optionally include a **Key Points** section for quick review.

---

## 5. Formatting Standards

| Element | Rule |
|----------|------|
| Bold | Use `**bold**` for emphasis |
| Italics | Use `_italics_` sparingly |
| Code | Use backticks for inline code (`np.array`) |
| Horizontal Rules | Use `---` to separate major sections |
| Line Breaks | Use double spaces at end of line for intentional breaks |
| ASCII Only | No emojis or special symbols |

---

## 6. Quality Checklist

Before finalizing a Markdown file, verify the following:

- [ ] Filename follows the naming convention.
- [ ] Title and section headings are properly structured.
- [ ] Overview section provides a clear summary.
- [ ] Context section aligns with multimedia content (if applicable).
- [ ] Each concept includes at least one example.
- [ ] Code blocks are syntactically correct and formatted.
- [ ] Summary or Key Points section is present and concise.
- [ ] No proprietary or non-ASCII content.
- [ ] Consistent use of Markdown syntax and spacing.
- [ ] Timestamps and contextual notes align with referenced multimedia content.

---

## 7. Example Template

```
# 1.1.X Topic Title

## Context (optional)
Brief description of the video or lesson this file accompanies.

## Overview
Brief description of what this section covers.

## Key Concepts
- Concept 1
- Concept 2

## Worked Examples
Example:
```python
import numpy as np
arr = np.arange(5)
print(arr)
```

## Summary
- Key takeaway 1
- Key takeaway 2
- Key takeaway 3
```

---

### Private Video Reference

> Access: Use your own Azure credentials or a short-lived SAS.  
> We do not publish proprietary media in this repository.
