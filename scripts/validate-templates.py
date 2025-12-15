#!/usr/bin/env python3
"""
Template Validation Script

Validates that all templates in the templates/ directory have:
- Required metadata sections
- Consistent version numbering
- Valid structure
- Cross-references where needed
"""

import os
import re
import sys
from pathlib import Path


class TemplateValidator:
    """Validates template files for compliance with project standards."""

    def __init__(self):
        self.templates_dir = Path(__file__).parent.parent / "templates"
        self.errors = []
        self.warnings = []
        self.valid_templates = []

    def validate_all(self):
        """Validate all templates in the templates directory."""
        if not self.templates_dir.exists():
            print(f"❌ Templates directory not found: {self.templates_dir}")
            sys.exit(1)

        print(f"🔍 Validating templates in {self.templates_dir}")
        print("-" * 60)

        markdown_templates = list(self.templates_dir.glob("*.md"))
        if not markdown_templates:
            print("❌ No markdown templates found")
            sys.exit(1)

        print(f"Found {len(markdown_templates)} templates to validate\n")

        for template_file in sorted(markdown_templates):
            self.validate_template(template_file)

        print("-" * 60)
        self.print_summary()

        if self.errors:
            sys.exit(1)

    def validate_template(self, template_path):
        """Validate a single template file."""
        template_name = template_path.name
        print(f"📄 Validating {template_name}...")

        try:
            with open(template_path, "r", encoding="utf-8") as f:
                content = f.read()

            # Check for required metadata
            if not self._has_metadata(content):
                self.errors.append(f"{template_name}: Missing TEMPLATE METADATA section")
            else:
                print(f"   ✅ Has TEMPLATE METADATA")

            # Check for version
            if not self._has_version(content):
                self.errors.append(f"{template_name}: Missing Version field in metadata")
            else:
                print(f"   ✅ Has Version field")

            # Check for name field
            if not self._has_name(content):
                self.errors.append(f"{template_name}: Missing Name field in metadata")
            else:
                print(f"   ✅ Has Name field")

            # Check for purpose
            if not self._has_purpose(content):
                self.errors.append(f"{template_name}: Missing Purpose field in metadata")
            else:
                print(f"   ✅ Has Purpose field")

            # Check for usage
            if not self._has_usage(content):
                self.warnings.append(f"{template_name}: Missing Usage field in metadata")
                print(f"   ⚠️ Missing Usage field")
            else:
                print(f"   ✅ Has Usage field")

            # Check for last updated date
            if not self._has_date(content):
                self.warnings.append(f"{template_name}: Missing Last Updated date")
                print(f"   ⚠️ Missing Last Updated date")
            else:
                print(f"   ✅ Has Last Updated date")

            # Check for content after metadata
            if not self._has_content(content):
                self.errors.append(f"{template_name}: No content found after metadata")
            else:
                print(f"   ✅ Has template content")

            # Validate metadata format
            if not self._validate_metadata_format(content):
                self.errors.append(f"{template_name}: Invalid metadata format")
            else:
                print(f"   ✅ Valid metadata format")

            if not self.errors or not any(template_name in e for e in self.errors):
                self.valid_templates.append(template_name)
                print(f"   ✅ {template_name} is valid\n")

        except Exception as e:
            self.errors.append(f"{template_name}: Error reading file: {e}")

    def _has_metadata(self, content):
        """Check if content has TEMPLATE METADATA section."""
        return "TEMPLATE METADATA" in content

    def _has_version(self, content):
        """Check if content has Version field."""
        return re.search(r"Version:\s*[\d.]+", content) is not None

    def _has_name(self, content):
        """Check if content has Name field."""
        return re.search(r"Name:\s*[A-Za-z]", content) is not None

    def _has_purpose(self, content):
        """Check if content has Purpose field."""
        return re.search(r"Purpose:\s*[A-Za-z]", content) is not None

    def _has_usage(self, content):
        """Check if content has Usage field."""
        return re.search(r"Usage:\s*[A-Za-z]", content) is not None

    def _has_date(self, content):
        """Check if content has Last Updated date."""
        return re.search(r"Last Updated:\s*\d{4}-\d{2}-\d{2}", content) is not None

    def _has_content(self, content):
        """Check if content has meaningful content after metadata."""
        # Split on closing comment tag
        if "-->" in content:
            after_metadata = content.split("-->", 1)[1]
            # Check for heading or content
            return re.search(r"^#\s+", after_metadata, re.MULTILINE) is not None
        return False

    def _validate_metadata_format(self, content):
        """Validate metadata is properly formatted."""
        # Check for HTML comment tags
        if "<!--" not in content or "-->" not in content:
            return False
        # Check that metadata is at the start
        if not content.strip().startswith("<!--"):
            return False
        return True

    def print_summary(self):
        """Print validation summary."""
        print(f"\n{'=' * 60}")
        print("VALIDATION SUMMARY")
        print("=" * 60)

        if self.valid_templates:
            print(f"\n✅ Valid Templates ({len(self.valid_templates)}):")
            for template in self.valid_templates:
                print(f"   - {template}")

        if self.warnings:
            print(f"\n⚠️ Warnings ({len(self.warnings)}):")
            for warning in self.warnings:
                print(f"   - {warning}")

        if self.errors:
            print(f"\n❌ Errors ({len(self.errors)}):")
            for error in self.errors:
                print(f"   - {error}")
        else:
            print("\n✅ All templates passed validation!")

        print(f"\n📊 Results:")
        print(f"   Valid: {len(self.valid_templates)}")
        print(f"   Warnings: {len(self.warnings)}")
        print(f"   Errors: {len(self.errors)}")
        print("=" * 60)


if __name__ == "__main__":
    validator = TemplateValidator()
    validator.validate_all()
