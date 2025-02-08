---
title: 'gtexr: A convenient R interface to the Genotype-Tissue Expression (GTEx) Portal API'
tags:
- R
- api-wrapper
- bioinformatics
- gtex
- eqtl
- sqtl
date: "7 February 2025"
output: pdf_document
authors:
  - name:
      given-names: Alasdair Neil
      surname: Warwick
    orcid: 0000-0002-0800-2890
    email: alasdair.warwick.19@ucl.ac.uk
    affiliation: [ 1, 2 ]
  - name:
      given-names: Benjamin
      surname: Zuckerman
    orcid: 0000-0002-0077-6074
    affiliation: 3
  - name:
      given-names: Chuin Ying
      surname: Ung
    orcid: 0000-0001-8487-4589
    affiliation: 5
  - name:
      given-names: Robert
      surname: Luben
    orcid: 0000-0002-5088-6343
    affiliation: [ 2, 4 ]
  - name:
      given-names: Abraham
      surname: Olvera-Barrios
    orcid: 0000-0002-3305-4465
    affiliation: [ 2, 4 ]
bibliography: paper.bib
affiliations:
- name: University College London Institute of Cardiovascular Science, London, UK
  index: 1
- name: NIHR Biomedical Research Centre, Moorfields Eye Hospital NHS Foundation Trust
  index: 2
- name: Centre for Rheumatic Diseases, King's College London, London, UK
  index: 3
- name: University College London Institute of Ophthalmology, London, UK
  index: 4
- name: Guy's and St Thomas' NHS Foundation Trust
  index: 5
---

# Summary

The Genotype-Tissue Expression (GTEx) project [@gtex2013; @gtex2020] is a comprehensive public resource for studying tissue-specific gene expression and regulation in human tissues. Through systematic analysis of RNA sequencing data from 54 non-diseased tissue sites across nearly 1000 individuals, GTEx provides crucial insights into the relationship between genetic variation and gene expression. This data is accessible through the GTEx Portal API [@gtexportal], enabling programmatic access to human gene expression data.

The `gtexr` package [@gtexr] provides a convenient R interface to the GTEx Portal API (v2), making this valuable resource more accessible to researchers. It offers a suite of R functions with intuitive naming conventions that mirror the complete set of API endpoints. The package includes comprehensive documentation with working examples for all functions, and is complemented by an interactive web application that allows users to explore the API functionality through a graphical interface. Common use cases include retrieving quantitative trait loci data for specific genes or variants, accessing tissue-specific expression data, and converting between different identifier systems (e.g., gene symbols to GENCODE IDs). Results are returned in tabular format, facilitating integration with downstream analysis pipelines and allowing researchers to focus on their analyses rather than API implementation details.

# Statement of need

GTEx data is extensively used across diverse areas of biomedical research, from basic regulatory genomics to clinical applications. For example, researchers use GTEx to investigate tissue-specific gene expression patterns, interpret genome-wide association study findings, and infer causal relationships between gene expression and disease. While the GTEx Portal provides a web interface for data access, many analyses require programmatic access to query multiple genes, variants, or tissues systematically.

Current tools for programmatic GTEx access are limited to either downloading bulk data releases or require significant programming expertise to construct API queries. `gtexr` [@gtexr] fills this gap by providing researchers with a straightforward interface to query GTEx data programmatically. 

# Acknowledgements

We acknowledge the GTEx project for providing the valuable data resource that this package accesses. The GTEx Project was supported by the Common Fund of the Office of the Director of the National Institutes of Health, and by NCI, NHGRI, NHLBI, NIDA, NIMH, and NINDS.

A.N.W. is supported by the Wellcome Trust (220558/Z/20/Z; 224390/Z/21/Z). A.O.-B. is supported by the Lowy Medical Research Institute, La Jolla, California. R.L. has received funding from the Medical Research Council (MR/N003284/1 and MC-UU_12015/1) and Cancer Research UK (C864/A14136) through the EPIC-Norfolk study. This research was supported by the National Institute for Health and Care Research (NIHR) Biomedical Research Centre based at Moorfields Eye Hospital NHS Foundation Trust and UCL Institute of Ophthalmology. The views expressed are those of the author(s) and not necessarily those of the NHS, the NIHR or the Department of Health and Social Care.

# References
