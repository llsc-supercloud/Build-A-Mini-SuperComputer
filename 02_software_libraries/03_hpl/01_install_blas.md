# Install BLAS

1. Navigate to /home/gridsan/software

2. Download libopenblas-openmp-dev_0.3.29+ds-3_arm64.deb to /home/gridsan/software

```bash
 admin@headnode$> wget http://ftp.us.debian.org/debian/pool/main/o/openblas/libopenblas-openmp-dev_0.3.29+ds-3_arm64.deb
````

3. Install BLAS in /home/gridsan/software

```bash
admin@headnode:/data/software/: dpkg-deb -R libopen* openblas
```

