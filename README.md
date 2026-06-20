# PHYSICOCHEMICAL WATER QUALITY TREATMENT ANALYTICS: A DATA-DRIVEN APPROACH.


## Overview:
This report presents a structured data analytics pipeline applied to a water quality dataset sourced from Kaggle. The objective is to evaluate treated water quality across 500 samples using physicochemical parameters, compute performance KPIs, and derive actionable insights relevant to environmental compliance and water treatment optimization.


## Sector: Environmental Sustainability in Chemical Engineering.
### Industry: 
Environmental Science, Public HealthCare
(Water Treatment & Quality Management)
### Period:
Across 500 sequential sample records.

## Problem Statement:
Poor water quality poses a critical risk to public health and aquatic ecosystems. Without systematic monitoring, treatment plants risk regulatory non-compliance and environmental harm. This study evaluates whether the sampled water meets World Health Organization (WHO) physicochemical standards and identifies parameters that require immediate treatment intervention.


## Tools Used:

### MS Excel:
Role: 
Initial data alignment, soft cleaning, KPI tables and summary.
No formulas or pivot-based analysis were performed in Excel; all analytical work was delegated to SQL for accuracy and reproducibility.

### SQL (MySQL WorkBench):
Role: Data Cleaning, Transformation, and Full KPI Analysis.
SQL was the primary analytical engine for this project, handling the majority of the data pipeline from raw import to fully analyzed output.

### Power BI:
Interactive dashboard and compliance visualisation


## Dataset:

Source: Kaggle - Water Quality Testing.csv
Records: 500 samples | Features: 6 parameters

### Data Summary:
> Storage Format - CSV

> Column | Unit | Description:
>> Sample ID | — | Unique sample identifier
>> pH | — | Acidity / alkalinity level
>> Temperature | °C | Water temperature
>> Turbidity | NTU | Suspended particle load
>> Dissolved Oxygen | mg/L| Oxygen available for aquatic life
>> Conductivity | µS/cm | Ionic concentration proxy

Data Quality: No null values detected. One sample exceeded the 5 Nephelometric Turbidity Unit (NTU) limit. No duplicates found.


## Processes:

### Step 1 ~ Data Collection:
Raw dataset (500 samples) downloaded from Kaggle in CSV format.

### Step 2 ~ Data Alignment (Excel)
Columns standardised, units verified, and structure checked in Excel prior to cleaning.

### Step 3 ~ Data Cleaning (MySQL)
Dataset loaded into MySQL; nulls, out-of-range values, and duplicates checked and removed.

##Step 4 ~ KPI Computation (MySQL)
Six KPIs calculated via SQL queries: turbidity reduction, DO saturation, pH/turbidity/overall compliance, and WQI.

### Step 5 ~ Visualization (Power BI)
KPI result tables imported into Power BI to build the dashboard and compliance visuals.


## Questions & KPIs:

### Research Questions:
Does the water meet WHO physicochemical limits?
How effective is turbidity removal relative to a 10 NTU influent benchmark?
What is the composite water quality score across all parameters?

### KPI Metrics:

> KPI | Formula | Threshold
>> 1. Turbidity Reduction (%) | (10 − Outlet NTU) / 10 × 100 | ≥ 80%

>> 2. DO Saturation (%) | Measured DO / 9.1 mg/L × 100 | ≥ 80%

>> 3. pH Compliance Rate (%) | pH within 6.5 & 8.5 / Total × 100 | 100%

>> 4. Turbidity Compliance Rate (%) | Turbidity ≤ 5 NTU / Total × 100 | 100%

>> 5. Overall Compliance Rate (%) | All 3 parameters within limits / Total × 100 | 100%

>> 6. Water Quality Index (WQI) | Composite: pH + Turbidity + DO + Conductivity (0–100) | > 75 = Good.

From my MySQL code,
KPIs 1–2 are computed per sample. 
KPIs 3–5 return a single aggregate rate. 
KPI 6 returns a per-sample composite score. 

All result tables feed directly into Power BI for dashboard creation.


## Visualization / Dashboarding (Power BI):

I imported the KPI result tables exported from the KPI calculations section of MySQL code directly into Power BI.
Screenshots were taken with the snipping tool.

![image alt](https://github.com/PromiseCPU/Physico-Chemical-Water-Quality-Treatment-Analytics/blob/bfaf07b860e681cda0ea4fd3ae76acacacf5ef26/b2_122939.png)


## Key Insights:

pH - Fully Compliant. All 500 samples fall within WHO range 6.5–8.5 (mean = 7.16), confirming stable treatment chemistry.
Dissolved Oxygen (DO) - Strong. Mean DO saturation of 92.1% exceeds the 80% aquatic life threshold, reflecting adequate aeration.
Turbidity - Near-Limit Risk. Mean turbidity of 4.17 NTU sits close to the 5 NTU WHO ceiling. One sample (0.2%) already breached it. Turbidity Reduction averaged only 58.3%, well below the 80% engineering target.
Overall Compliance: 99.8%. Only 1 of 500 samples failed, solely due to turbidity exceedance.
Water Quality Index (WQI) - Moderate at 65.1/100. The composite score falls below the 75-point "Good" threshold, driven by turbidity performance and conductivity variability (316–370 µS/cm).
Conductivity Variability. A spread of 54 µS/cm across samples indicates minor mineralisation fluctuation, manageable but worth monitoring.


## Conclusion:

The dataset demonstrates near-full WHO compliance on pH and dissolved oxygen. However, turbidity removal efficiency (58.3%) falls short of the 80% benchmark, and the WQI of 65.1/100 classifies overall water quality as moderate. The single turbidity exceedance, while isolated, signals a process vulnerability that could go off under higher influent loads.

## Recommendations:

Optimize Coagulation/Flocculation: Adjust alum or polymer dosing to drive turbidity reduction above 80%.

Set an Early-Warning Turbidity Threshold: Trigger corrective action at 4.5 NTU, not at the 5 NTU limit.

Monitor Conductivity Trends: Introduce monthly reporting to catch mineralisation drift early.

Adopt WQI as an Operational Metric: Target WQI > 75 as the standard operational benchmark.

Expand Future Dataset Scope: Incorporate Biological Oxygen Demand (BOD), Chemical Oxygen Demand (COD), and heavy metals for a more comprehensive treatment performance study.


Thank you for your time.
(Q.E.D)



