# CI/CD BLINK IN SYNC — Roblox Studio

## Install
1. Open your Roblox Studio place.
2. Select **View → Command Bar**.
3. Paste the contents of `Build_CICD_BlinkInSync.lua` into the Command Bar and press Enter.
4. Press **Play** and use **E** at BUILD, TEST, VALIDATE, then DEPLOY.

## Included
- Floating island blockout with grass, cliff face and water.
- Main CI/CD billboard and cyan synchronization rail.
- Four connected station assemblies with ProximityPrompts.
- Server-side sequential checkpoint progression.
- Deployment gate that remains locked until BUILD, TEST and VALIDATE pass.
- Player attributes `CICDProgress` and `CICDStatus` for a future HUD.

## MeshParts / FBX
This starter creates a functional Parts-based blockout. It does not claim to include an imported FBX or a fabricated Roblox MeshId. To replace the blockout with your designed low-poly MeshParts:
1. Export your environment from your DCC tool as FBX.
2. Import it with Roblox Studio's **3D Importer**.
3. Move the imported MeshParts into `Workspace.CICD_BlinkInSync`.
4. Keep the named interaction pads, ProximityPrompts and `Deployment_Gate`.
5. Anchor static environment meshes, or unanchor and connect them to `Island_Core` with WeldConstraints if you need a movable assembly.

## Production limitations
- Checkpoint progress is held in server memory and resets when the player leaves or the server restarts.
- The checkpoint stages simulate a pipeline; they do not execute external CI builds, tests, or deployments.
- Add a client HUD reading `CICDStatus` / `CICDProgress`, persistence if required, and exploit testing before publishing.
