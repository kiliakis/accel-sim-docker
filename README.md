
## Accel-sim Docker Image
A dockerfile that sets up a working accelsim environment.

### Usage instructions
1) Download the necessary data files:
    ```bash
    cd container_data
    bash download_data.sh
    cd ..
    ```
    
2) Build the docker image
    ```bash
    bash 0-build.sh
    ```

3) Create and start the container:
    ```bash
    bash 1-create.sh && bash 2-start.sh
    ```

4) Log in the container:
    ```bash
    bash 3-exec.sh
    ```

5) From within the container, finalize the installation with:
    ```bash
    bash finalize_installation.sh
    ```

6) To log-out use the `exit()` command or CTRL-D.

7) When done, you can stop the container (**you will lose all data stored in the container**), with:
    ```bash
    bash 4-stop.sh
    ```

