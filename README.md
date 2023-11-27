# CHOICE NMAP

# CTF Scanning Tool

It's a little tool for network scanning and analysis, providing a user-friendly interface for `nmap` and enhancing the readability and presentation of scan results.

## Features

- **User Selection**: The script presents the user with five options: a quick scan of the top 100 ports, a normal scan of all ports and services, an exhaustive scan that may take a long time, a scan of UDP ports, or exit the script.
- **Scan Execution**: Based on the user's selection, the script executes the appropriate `nmap` command.
- **Output Formatting**: The `nmap` command includes the `--stylesheet` option, which specifies a custom XSL stylesheet hosted on GitHub. This stylesheet transforms the XML output of the `nmap` scan into a beautiful, responsive, and interactive XML report.
- **OS Detection**: The script attempts to determine the operating system of the scanned host based on the TTL value.
- **Result Presentation**: The script presents the scan results, including the IP address, operating system (if detected), and open ports. The open ports are also copied to the clipboard.
- **Detailed Scan**: If the user selected the quick scan, normal scan, exhaustive scan, or UDP scan options, the script performs a more detailed scan on the found ports using the `-sCV` option. The results of this scan are also formatted as an XML report using the same XSL stylesheet.

![menuchoice](https://github.com/4ndymcfly/choice-nmap/assets/30553433/66a79c5c-c84f-4a5b-a46d-d70aadd34e7e)

![scanchoice](https://github.com/4ndymcfly/choice-nmap/assets/30553433/44927735-0453-4538-8974-2e4bb6a389ca)

## How to Use

1. **Clone the repository**: First, clone this repository to your local machine using `git clone https://github.com/4ndymcfly/choice-nmap`.

2. **Navigate to the directory**: Use the command `cd choice-nmap` to navigate to the directory where the script is located.

3. **Run the script**: Use the command `./choiceNmap.sh <target_IP>` to run the script. If permission is denied, you may need to make the script executable with the command `chmod +x ./choiceNmap.sh`.

4. **Select an option**: The script will present you with five options: a quick scan of the top 100 ports, a normal scan of all ports and services, an exhaustive scan that may take a long time, a scan of UDP ports, or exit the script. Enter the number of your selected option.

5. **Wait for the scan to complete**: The script will now perform the selected scan. Depending on the type of scan and the size of the network, this may take some time.

6. **View the results**: Once the scan is complete, the script will present the results, including the IP address, operating system (if detected), and open ports. The open ports are also copied to the clipboard.

7. **View the XML report**: To view the detailed HTML report, open your web browser and enter the address of your local server followed by the name of your XML file.

![report_black](https://github.com/4ndymcfly/choice-nmap/assets/30553433/ae06b1c8-8154-4501-857b-798e432616ee)

![report_black01](https://github.com/4ndymcfly/choice-nmap/assets/30553433/e98cb140-f070-400d-a5ba-e28e44fa6c75)

![report_black02](https://github.com/4ndymcfly/choice-nmap/assets/30553433/77d901bc-8c2d-4827-924b-d351fc29a7a4)

## Viewing the XML Report

To view the XML report generated by the `nmap` scan in your web browser, follow these steps:
1. Start a local server in the directory where your XML file is located. You can do this with Python or PHP. For Python 3, you can use the command `python3 -m http.server`, and for PHP, you can use the command `php -S localhost:8000`.
1. Open your web browser and enter the address of your local server followed by the name of your XML file. For example, if your file is named `targeted.xml`, you would enter `http://localhost:8000/targeted.xml` in your browser’s address bar.
2. Once the XML file is open in your browser, you can interact with the report. The page provides a responsive and interactive interface, allowing you to easily view and understand the results of your scan.

The `--stylesheet=https://raw.githubusercontent.com/honze-net/nmap-bootstrap-xsl/stable/nmap-bootstrap.xsl` option in the `nmap` command is used to specify a custom XSL stylesheet for formatting the XML output. This particular stylesheet, hosted on GitHub by user honze-net (https://github.com/honze-net/nmap-bootstrap-xsl), is called `nmap-bootstrap-xsl`. It transforms the XML output of an `nmap` scan into a beautiful, responsive, and interactive XML report. This makes it easier to read and understand the results of the scan, especially when dealing with large networks or complex scans. The HTML report includes features such as a summary of the scan, a list of open ports, and detailed information about each scanned host. It’s a great tool for enhancing the readability and presentation of your `nmap` scan results. 😊

Remember, the HTML report is static and won’t update if you run the scan again. You’ll need to refresh the page in your browser to see any new results after re-running the scan.


