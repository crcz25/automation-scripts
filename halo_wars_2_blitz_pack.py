import argparse
import logging
import logging.config
from time import sleep

import pyautogui
from tqdm import tqdm


def main(num_packs: int):
    # Create and configure logger
    logging.config.fileConfig("log.conf")
    logger = logging.getLogger(__name__)
    logger.info("Starting the script")

    for i in tqdm(range(num_packs), desc="Opening packs", unit="packs"):
        try:
            package_icon_pos = (378, 530)
            back_button_pos = (144, 966)

            # Move the mouse to the package icon
            pyautogui.moveTo(package_icon_pos)
            sleep(1.5)

            # Click the package icon to open the pack
            pyautogui.click(button="left")
            sleep(1.5)

            # Click the right icon to skip the animation
            pyautogui.click(button="right")
            sleep(1.5)

            # Click the back button to return to the main menu
            pyautogui.moveTo(back_button_pos)
            pyautogui.click(button="left")
            sleep(1.5)

        except Exception as e:
            logger.error(f"An error occurred: {e}")
            exit(1)
        except KeyboardInterrupt as e:
            logger.info("Exiting the script: User interrupted")
            exit(0)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Automate the opening of Blitz packs in Halo Wars 2"
    )
    parser.add_argument("--packs", type=int, default=1, help="Number of packs to open")
    args = parser.parse_args()
    main(args.packs)
