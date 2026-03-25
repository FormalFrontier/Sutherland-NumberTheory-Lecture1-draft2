#!/usr/bin/env python3
"""Stages 1.5-1.6: Structure analysis and blob extraction."""

import json
import os
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent
PAGES_DIR = REPO_ROOT / "pages"
BLOBS_DIR = REPO_ROOT / "blobs"

# Blob definitions:
# (id, type, title, start_page, end_page, start_line, end_line)
# - For single-page blobs: start_page == end_page; start_line/end_line are 1-indexed lines in that page.
# - For multi-page blobs: start_page < end_page; start_line is in start_page, end_line is in end_page.
BLOBS = [
    # Page 1
    ("Chapter1/Introduction",                   "introduction", "Chapter 1 Introduction: Absolute values and discrete valuations",  "1", "1",  1, 16),
    ("Chapter1/Remark1_1",                       "remark",       "Remark 1.1 (Rings)",                                               "1", "1", 17, 18),
    ("Chapter1/Section1_2_Intro",                "introduction", "Section 1.2 Introduction: Absolute values",                        "1", "1", 19, 22),
    ("Chapter1/Definition1_2",                   "definition",   "Definition 1.2 (Absolute value)",                                  "1", "1", 23, 33),
    # Page 2
    ("Chapter1/Example1_3",                      "example",      "Example 1.3 (Trivial absolute value)",                             "2", "2",  1,  6),
    ("Chapter1/Lemma1_4",                        "lemma",        "Lemma 1.4 (Nonarchimedean characterization)",                      "2", "2",  7, 14),
    ("Chapter1/Corollary1_5",                    "corollary",    "Corollary 1.5 (Positive characteristic fields)",                   "2", "2", 15, 18),
    ("Chapter1/Definition1_6",                   "definition",   "Definition 1.6 (Equivalent absolute values)",                      "2", "2", 19, 20),
    ("Chapter1/Section1_3_Intro",                "introduction", "Section 1.3 Introduction: Absolute values on Q",                   "2", "2", 21, 24),
    ("Chapter1/Definition1_7",                   "definition",   "Definition 1.7 (p-adic valuation and absolute value)",             "2", "2", 25, 34),
    ("Chapter1/Theorem1_8",                      "theorem",      "Theorem 1.8 (Ostrowski's Theorem)",                                "2", "2", 35, 38),
    ("Chapter1/Theorem1_9",                      "theorem",      "Theorem 1.9 (Product Formula)",                                    "2", "2", 39, 43),
    # Page 3
    ("Chapter1/Section1_4_Intro",                "introduction", "Section 1.4 Introduction: Discrete valuations",                    "3", "3",  1,  2),
    ("Chapter1/Definition1_10",                  "definition",   "Definition 1.10 (Valuation, discrete valuation, DVR)",             "3", "3",  3, 12),
    ("Chapter1/Discussion_after_Definition1_10", "discussion",   "Discussion: Properties of valuation rings",                        "3", "3", 13, 18),
    ("Chapter1/Definition1_11",                  "definition",   "Definition 1.11 (Valuation ring)",                                 "3", "3", 19, 20),
    ("Chapter1/Discussion_after_Definition1_11", "discussion",   "Discussion: Uniformizers and ideals in DVRs",                      "3", "3", 21, 33),
    # Page 4
    ("Chapter1/Definition1_12",                  "definition",   "Definition 1.12 (Local ring)",                                     "4", "4",  1,  2),
    ("Chapter1/Definition1_13",                  "definition",   "Definition 1.13 (Residue field)",                                  "4", "4",  3,  4),
    ("Chapter1/Discussion_after_Definition1_13", "discussion",   "Discussion: Determining valuation from a DVR",                     "4", "4",  5,  8),
    ("Chapter1/Example1_14",                     "example",      "Example 1.14 (Z_(p) for p-adic valuation)",                        "4", "4",  9, 14),
    ("Chapter1/Example1_15",                     "example",      "Example 1.15 (Laurent series valuation)",                          "4", "4", 15, 20),
    # Multi-page: page 4 lines 21-30 + page 5 lines 1-4
    ("Chapter1/Section1_5_Intro",                "introduction", "Section 1.5 Introduction: Properties of DVRs",                     "4", "5", 21,  4),
    # Page 5 (after multi-page blob)
    ("Chapter1/Theorem1_16",                     "theorem",      "Theorem 1.16 (Characterizations of DVRs)",                         "5", "5",  5, 16),
    ("Chapter1/Section1_6_Intro",                "introduction", "Section 1.6 Introduction: Integral extensions",                    "5", "5", 17, 20),
    ("Chapter1/Definition1_17",                  "definition",   "Definition 1.17 (Integral element and integral ring extension)",    "5", "5", 21, 22),
    ("Chapter1/Proposition1_18",                 "proposition",  "Proposition 1.18 (Sum and product of integral elements)",          "5", "5", 23, 40),
    # Page 6
    ("Chapter1/Definition1_19",                  "definition",   "Definition 1.19 (Integral closure)",                               "6", "6",  1,  2),
    ("Chapter1/Proposition1_20",                 "proposition",  "Proposition 1.20 (Transitivity of integrality)",                   "6", "6",  3,  6),
    ("Chapter1/Corollary1_21",                   "corollary",    "Corollary 1.21 (Integral closure is integrally closed)",           "6", "6",  7, 10),
    ("Chapter1/Proposition1_22",                 "proposition",  "Proposition 1.22 (Z is integrally closed)",                        "6", "6", 11, 22),
    ("Chapter1/Corollary1_23",                   "corollary",    "Corollary 1.23 (UFDs are integrally closed)",                      "6", "6", 23, 26),
    ("Chapter1/Example1_24",                     "example",      "Example 1.24 (Z[sqrt(5)] is not integrally closed)",               "6", "6", 27, 28),
    ("Chapter1/Discussion_after_Example1_24",    "discussion",   "Discussion: DVRs and valuation rings are integrally closed",       "6", "6", 29, 30),
    ("Chapter1/Proposition1_25",                 "proposition",  "Proposition 1.25 (Valuation rings are integrally closed)",         "6", "6", 31, 41),
    # Page 7
    ("Chapter1/Definition1_26",                  "definition",   "Definition 1.26 (Number field and ring of integers)",              "7", "7",  1,  2),
    ("Chapter1/Remark1_27",                      "remark",       "Remark 1.27 (Notation for ring of integers)",                      "7", "7",  3,  4),
    ("Chapter1/Proposition1_28",                 "proposition",  "Proposition 1.28 (Minimal polynomial and integrality)",            "7", "7",  5, 12),
    ("Chapter1/Example1_29",                     "example",      "Example 1.29 (Integral check for (1+sqrt(7))/2)",                  "7", "7", 13, 14),
    ("Chapter1/References",                      "bibliography", "References",                                                       "7", "7", 15, 21),
]


def load_pages():
    """Load all page files as lists of lines (with newlines stripped on trailing)."""
    pages = {}
    for i in range(1, 8):
        page_file = PAGES_DIR / f"{i}.md"
        with open(page_file) as f:
            pages[str(i)] = f.readlines()
    return pages


def extract_blob_content(pages, start_page, end_page, start_line, end_line):
    """Extract content for a blob. Lines are 1-indexed."""
    if start_page == end_page:
        page_lines = pages[start_page]
        return "".join(page_lines[start_line - 1 : end_line])
    else:
        # Multi-page blob: collect lines from start_page through end_page
        result = []
        # Determine all pages in range
        page_nums = list(range(int(start_page), int(end_page) + 1))
        for page_num in page_nums:
            page_str = str(page_num)
            page_lines = pages[page_str]
            if page_str == start_page:
                result.extend(page_lines[start_line - 1:])
            elif page_str == end_page:
                result.extend(page_lines[:end_line])
            else:
                result.extend(page_lines)
        return "".join(result)


def build_items_json():
    """Build items.json list."""
    items = []
    for blob_id, blob_type, title, start_page, end_page, start_line, end_line in BLOBS:
        items.append({
            "id": blob_id,
            "type": blob_type,
            "title": title,
            "start_page": start_page,
            "end_page": end_page,
            "start_line": start_line,
            "end_line": end_line,
        })
    return items


def write_blob_files(pages):
    """Write one .md file per blob."""
    BLOBS_DIR.mkdir(parents=True, exist_ok=True)
    for blob_id, blob_type, title, start_page, end_page, start_line, end_line in BLOBS:
        content = extract_blob_content(pages, start_page, end_page, start_line, end_line)
        blob_path = BLOBS_DIR / (blob_id + ".md")
        blob_path.parent.mkdir(parents=True, exist_ok=True)
        with open(blob_path, "w") as f:
            f.write(content)
    print(f"Wrote {len(BLOBS)} blob files to {BLOBS_DIR}")


def run_contiguity_check(pages):
    """Verify every line of every page belongs to exactly one blob."""
    # Build a coverage map: (page, line_number) -> blob_id
    coverage = {}
    for blob_id, blob_type, title, start_page, end_page, start_line, end_line in BLOBS:
        page_nums = list(range(int(start_page), int(end_page) + 1))
        for page_num in page_nums:
            page_str = str(page_num)
            page_lines = pages[page_str]
            if start_page == end_page:
                line_range = range(start_line, end_line + 1)
            elif page_str == start_page:
                line_range = range(start_line, len(page_lines) + 1)
            elif page_str == end_page:
                line_range = range(1, end_line + 1)
            else:
                line_range = range(1, len(page_lines) + 1)
            for ln in line_range:
                key = (page_str, ln)
                if key in coverage:
                    print(f"OVERLAP: line {ln} of page {page_str} claimed by both '{coverage[key]}' and '{blob_id}'")
                else:
                    coverage[key] = blob_id

    # Check for gaps
    errors = []
    for page_num in range(1, 8):
        page_str = str(page_num)
        total_lines = len(pages[page_str])
        for ln in range(1, total_lines + 1):
            if (page_str, ln) not in coverage:
                errors.append(f"GAP: line {ln} of page {page_str} not in any blob")

    if errors:
        print("CONTIGUITY CHECK FAILED:")
        for e in errors:
            print(f"  {e}")
        return False
    else:
        print(f"Contiguity check PASSED: {len(coverage)} lines covered across all pages")
        return True


def verify_reconstruction(pages):
    """Verify that concatenating blob files in order reproduces the complete text."""
    # Build expected text (all pages concatenated)
    expected = ""
    for i in range(1, 8):
        expected += "".join(pages[str(i)])

    # Build actual text from blobs in order
    actual = ""
    for blob_id, _, _, start_page, end_page, start_line, end_line in BLOBS:
        blob_path = BLOBS_DIR / (blob_id + ".md")
        with open(blob_path) as f:
            actual += f.read()

    if expected == actual:
        print("Reconstruction check PASSED: blob concatenation reproduces complete text")
        return True
    else:
        # Find first difference
        for i, (a, b) in enumerate(zip(expected, actual)):
            if a != b:
                print(f"Reconstruction FAILED at character {i}:")
                print(f"  Expected: {repr(expected[max(0,i-20):i+40])}")
                print(f"  Got:      {repr(actual[max(0,i-20):i+40])}")
                break
        if len(expected) != len(actual):
            print(f"Length mismatch: expected {len(expected)}, got {len(actual)}")
        return False


def main():
    pages = load_pages()

    # Check page line counts
    for i in range(1, 8):
        print(f"Page {i}: {len(pages[str(i)])} lines")

    # Write items.json
    items = build_items_json()
    items_path = REPO_ROOT / "items.json"
    with open(items_path, "w") as f:
        json.dump(items, f, indent=2)
        f.write("\n")
    print(f"Wrote {len(items)} items to {items_path}")

    # Write blob files
    write_blob_files(pages)

    # Run checks
    ok1 = run_contiguity_check(pages)
    ok2 = verify_reconstruction(pages)

    if ok1 and ok2:
        print("\nAll checks PASSED. Stages 1.5-1.6 complete.")
    else:
        print("\nSome checks FAILED. Review errors above.")
        exit(1)


if __name__ == "__main__":
    main()
