# UNC Medical Center Standard Charges Dataset

## Summary

I’ve selected a dataset from UNC Health’s website related to standard charges for hospital-based procedures, services, drugs, etc. (UNC Health, 2021). Healthcare insurance and affordability of care is an important topic to the public – though deeply complicated to solve. The availability of this data is a result of a relatively new policy from Centers for Medicare & Medicaid Services (CMS) that requires US hospitals to publicly post charges. The policy seeks to provide better education to consumers, increased competition among hospitals and long-term, curtail healthcare costs. As a first step, The Hospital Price Transparency Rule went into effect January 1, 2021 (CMS, 2019) and is a leading indicator of additional legislation, executive orders and policies that seek to address the enormous challenge of expensive healthcare in the US.

Both professionally and personally, I have a strong interest in healthcare innovation. Development of new therapies, medical devices, diagnostics and other technologies are essential to providing better patient care. Though such innovations are only part of the equation – healthcare economics is the other. Throughout my work on this project, I seek to better understand cost-effective, and cost-ineffective aspects of care at UNC Health.

## Purpose

This project seeks to explore charge variability across various healthcare services provided at UNC Health, other UNC Health systems and if feasible, other North Carolina-based health systems. In addition, the data includes charges from 36 healthcare insurance providers associated with a given charge bundle (i.e., collections of procedures, services and care provided for common treatments). I hope to use the tools and techniques I learn in the Intro to Data Science course to provide insights about the following:

* Price range differences
* Variability of ‘charge bundles’ across insurance providers
* Subsets of data related to patients receiving care for COVID-19 and/or pediatric tracheostomies
* Comparison of other hospital datasets, in particular, differences among non-profit and for-profit health systems
* Linkage with other relevant datasets

## Instalation Instructions

TODO

### Step 1: Install Docker

TODO

### Step 2: Clone Git Repository

TODO

### Step 3: Build Docker

````bash
#!/bin/bash
docker build -t charges-docker .
````

### Step 4: Start Rstudio

```bash
#!/bin/bash
docker run -e PASSWORD=homehealth --rm -p 8787:8787 -v $(pwd):/home/rstudio/charge-project charges-docker
```

And visit http://localhost:8787 in your browser. Log in with user `rstudio` and password `homehealth`.

## Additional Information

TODO

## Data Scope

The dataset was accessed on Aug 24, 2021 and exported as a .csv file. It includes:

* 5011 charge bundles
* Standard, minimum, maximum prices per ‘charge bundle’
* 36 payors, including Blue Cross Blue Shield North Carolina (Note: one price per ‘charge bundle’)
* Cross-referenced medical codes; Medicare Severity-Diagnosis Related Group (MS-DRG) / Current Procedural Terminology (CPT) / Healthcare Common Procedure Coding System (HCPCS), as available

## References

CMS. (2019, November 27). Hospital Price Transparency Rule. Retrieved August 30, 2021, from <https://www.cms.gov/hospital-price-transparency>

UNC Health. (2021, January 1). CDM Standard Charges & Shoppable Services. Retrieved August 30, 2021, from <https://portalapprev.com/ptapp/#d4ccc071fab9c79f17e52dc5b243ef668affc5e569aafa907c5b4c81f0a89284>
