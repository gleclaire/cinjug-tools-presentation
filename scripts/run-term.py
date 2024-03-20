#!/usr/bin/env python3

####################################
#
# To Run Do Following:
# Install iTerm scripting
#
# brew install python3
# pip3 install iterm2
# pip3 install pyobjc
#
####################################


import iterm2
# import AppKit
import sys

directory = sys.argv[1]

sample_project_directory = "cd " + directory + "\n"

async def main(connection):
    app = await iterm2.async_get_app(connection)
    window = app.current_terminal_window
    if window is not None:


        # Open Sample Project Server
        await window.async_create_tab()
        session = app.current_terminal_window.current_tab.current_session
        update = iterm2.LocalWriteOnlyProfile()
        update.set_allow_title_setting(False)
        update.set_use_custom_window_title(True)
        update.set_name("Sample Project Server")
        await session.async_set_profile_properties(update)
        await session.async_send_text(sample_project_directory)
        await session.async_send_text('docker exec -it sample_project_jhipster bash\n')
        await session.async_send_text('./mvnw -Dskip.installnodenpm -Dskip.npm -DskipTests -Djdk.lang.Process.launchMechanism=vfork spring-boot:run\n')

        # Open Sample Project UI
        await window.async_create_tab()
        session = app.current_terminal_window.current_tab.current_session
        update = iterm2.LocalWriteOnlyProfile()
        update.set_allow_title_setting(False)
        update.set_use_custom_window_title(True)
        update.set_name("Sample Project UI")
        await session.async_send_text('docker exec -it sample_project_jhipster bash\n')
        await session.async_set_profile_properties(update)
        # await session.async_send_text(sample_project_directory)
        await session.async_send_text('npm install\n')
        await session.async_send_text('npm start\n')

    else:
        print("No current window")

iterm2.run_until_complete(main)
